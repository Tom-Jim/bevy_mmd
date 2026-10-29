// Page boot: start the wasm viewer on the canvas and publish the bridge the React
// panels use (src/ui/src/host.ts) on `globalThis.mmd`.

const status = document.getElementById("status");

function fail(error) {
  status.textContent = String(error && error.stack ? error.stack : error);
  console.error(error);
}

if (!navigator.gpu) {
  fail("This page needs WebGPU (a current Chrome, Edge or Safari).");
}

addEventListener("TrunkApplicationStarted", () => {
  try {
    const wasm = window.wasmBindings;
    window.mmd = {
      ...(window.mmd ?? {}),
      command: (json) => wasm.command(json),
      loadFiles: (paths, files) => wasm.loadFiles(paths, files),
    };
    status.textContent = "";
    wasm.boot(new URL("assets", document.baseURI).href);
  } catch (error) {
    fail(error);
  }
});
