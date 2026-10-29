import { useEffect, useRef, useState } from "react";
import type { Host } from "./host";
import type { PickedFile, Status } from "./types";
import { fromDrop, fromInput } from "./files";

const time = (s: number) => {
  const m = Math.floor(s / 60);
  return `${m}:${Math.floor(s % 60).toString().padStart(2, "0")}`;
};

export function App({ host }: { host: Host }) {
  const [status, setStatus] = useState<Status | null>(null);
  const [scrub, setScrub] = useState<number | null>(null);
  const [dragging, setDragging] = useState(false);
  const [busy, setBusy] = useState(false);
  const folder = useRef<HTMLInputElement>(null);
  const motion = useRef<HTMLInputElement>(null);

  useEffect(() => host.onStatus(setStatus), [host]);

  const load = async (files: PickedFile[]) => {
    if (files.length === 0) return;
    setBusy(true);
    try {
      await host.loadFiles(files);
    } finally {
      setBusy(false);
    }
  };

  const s = status;
  const playing = s?.playing ?? false;
  const duration = s?.duration ?? 0;
  const shown = scrub ?? s?.time ?? 0;

  return (
    <div
      className="layer"
      onDragOver={(e) => {
        if (!host.handlesDrops) return;
        e.preventDefault();
        setDragging(true);
      }}
      onDragLeave={() => setDragging(false)}
      onDrop={async (e) => {
        if (!host.handlesDrops) return;
        e.preventDefault();
        setDragging(false);
        await load(await fromDrop(e.dataTransfer.items));
      }}
    >
      {host.forwardsPointer && <PointerPad host={host} />}

      <header className="panel top">
        <div className="title">
          <strong>{s?.model ?? "No model"}</strong>
          <span>{s?.motion ?? "No motion"}</span>
        </div>
        <div className="actions">
          <button onClick={() => folder.current?.click()}>Open model folder</button>
          <button onClick={() => motion.current?.click()}>Open motion (VMD)</button>
          <input
            ref={folder}
            type="file"
            hidden
            multiple
            {...{ webkitdirectory: "" }}
            onChange={async (e) => load(await fromInput(e.currentTarget.files))}
          />
          <input ref={motion} type="file" hidden accept=".vmd" onChange={async (e) => load(await fromInput(e.currentTarget.files))} />
        </div>
      </header>

      <aside className="panel side">
        <h3>Physics</h3>
        <Toggle label="Rigid bodies (hair, cloth)" on={s?.physics} onChange={(on) => host.send({ cmd: "physics", on })} />
        <Toggle label="Chest and hip jiggle" on={s?.jiggle} onChange={(on) => host.send({ cmd: "jiggle", on })} />
        <label className="slider">
          <span>Jiggle strength {(s?.jiggle_strength ?? 1).toFixed(2)}</span>
          <input
            type="range"
            min={0}
            max={2}
            step={0.05}
            value={s?.jiggle_strength ?? 1}
            onChange={(e) => host.send({ cmd: "jiggle", on: true, strength: Number(e.currentTarget.value) })}
          />
        </label>
        <button onClick={() => host.send({ cmd: "reset_physics" })}>Reset physics</button>
        <h3>Display</h3>
        <Toggle label="Outline" on={s?.outline} onChange={(on) => host.send({ cmd: "outline", on })} />
        <Toggle label="Loop" on={s?.looping} onChange={(on) => host.send({ cmd: "loop", on })} />
        <button onClick={() => host.send({ cmd: "reset_view" })}>Reset view</button>
        {s && (
          <dl className="stats">
            <dt>Frame rate</dt>
            <dd>{s.fps.toFixed(0)} fps</dd>
            <dt>Vertices</dt>
            <dd>{s.vertices.toLocaleString()}</dd>
            <dt>Bones</dt>
            <dd>{s.bones}</dd>
            <dt>Rigid bodies</dt>
            <dd>
              {s.bodies} ({s.dynamic_bodies} dynamic)
            </dd>
            <dt>Jiggle bones</dt>
            <dd>{s.jiggle_bones}</dd>
            <dt>Morphs</dt>
            <dd>{s.morphs}</dd>
          </dl>
        )}
      </aside>

      <footer className="panel bottom">
        <button className="play" onClick={() => host.send({ cmd: "play", playing: !playing })} aria-label={playing ? "Pause" : "Play"}>
          {playing ? "❚❚" : "▶"}
        </button>
        <span className="clock">
          {time(shown)} / {time(duration)}
        </span>
        <input
          className="seek"
          type="range"
          min={0}
          max={Math.max(duration, 0.01)}
          step={1 / 30}
          value={shown}
          onChange={(e) => {
            const t = Number(e.currentTarget.value);
            setScrub(t);
            host.send({ cmd: "seek", time: t });
          }}
          onPointerUp={() => setScrub(null)}
        />
        <select value={s?.speed ?? 1} onChange={(e) => host.send({ cmd: "speed", value: Number(e.currentTarget.value) })}>
          {[0.25, 0.5, 1, 1.5, 2].map((v) => (
            <option key={v} value={v}>
              {v}×
            </option>
          ))}
        </select>
      </footer>

      {(s?.loading || busy) && <div className="toast">Loading…</div>}
      {!s?.loading && s?.notice && <div className={`toast ${s.notice_fault ? "fault" : ""}`}>{s.notice}</div>}
      {dragging && <div className="drop">Drop to load a PMX model folder or a VMD motion</div>}
      {!s?.model && !s?.loading && <div className="hint">Drop a PMX model folder and a VMD motion here, or use the buttons above</div>}
    </div>
  );
}

function Toggle({ label, on, onChange }: { label: string; on?: boolean; onChange: (on: boolean) => void }) {
  return (
    <label className="toggle">
      <input type="checkbox" checked={on ?? false} onChange={(e) => onChange(e.currentTarget.checked)} />
      <span>{label}</span>
    </label>
  );
}

/** Under Tauri the webview covers Bevy: forward the background's pointer to the viewer. */
function PointerPad({ host }: { host: Host }) {
  return (
    <div
      className="pad"
      onPointerMove={(e) => host.send({ cmd: "pointer", x: e.clientX, y: e.clientY })}
      onPointerDown={(e) => {
        e.currentTarget.setPointerCapture(e.pointerId);
        host.send({ cmd: "pointer", x: e.clientX, y: e.clientY, button: e.button, down: true });
      }}
      onPointerUp={(e) => host.send({ cmd: "pointer", x: e.clientX, y: e.clientY, button: e.button, down: false })}
      onWheel={(e) => host.send({ cmd: "wheel", dy: e.deltaY })}
      onContextMenu={(e) => e.preventDefault()}
    />
  );
}
