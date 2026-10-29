// Reading picked folders and dropped items into (relative path, bytes) pairs.

import type { PickedFile } from "./types";

const WANTED = /\.(pmx|vmd|png|jpe?g|bmp|tga|spa|sph|dds|gif)$/i;

export async function fromInput(list: FileList | null): Promise<PickedFile[]> {
  const files = Array.from(list ?? []).filter((f) => WANTED.test(f.name));
  return Promise.all(
    files.map(async (f) => ({
      path: (f as File & { webkitRelativePath?: string }).webkitRelativePath || f.name,
      bytes: new Uint8Array(await f.arrayBuffer()),
    })),
  );
}

/** Dropped files and folders, walked recursively. */
export async function fromDrop(items: DataTransferItemList): Promise<PickedFile[]> {
  const out: PickedFile[] = [];
  const walk = async (entry: FileSystemEntry, prefix: string): Promise<void> => {
    if (entry.isFile) {
      if (!WANTED.test(entry.name)) return;
      const file = await new Promise<File>((resolve, reject) => (entry as FileSystemFileEntry).file(resolve, reject));
      out.push({ path: prefix + entry.name, bytes: new Uint8Array(await file.arrayBuffer()) });
    } else if (entry.isDirectory) {
      const reader = (entry as FileSystemDirectoryEntry).createReader();
      // readEntries returns batches until an empty one.
      for (;;) {
        const batch = await new Promise<FileSystemEntry[]>((resolve, reject) => reader.readEntries(resolve, reject));
        if (batch.length === 0) break;
        for (const child of batch) await walk(child, `${prefix}${entry.name}/`);
      }
    }
  };
  const entries = Array.from(items)
    .map((item) => item.webkitGetAsEntry())
    .filter((e): e is FileSystemEntry => e !== null);
  for (const entry of entries) await walk(entry, "");
  return out;
}
