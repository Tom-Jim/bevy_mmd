// The viewer calls `mmd.emit(json)` with its status; the panels listen for the event.
window.mmd = {
  ...(window.mmd ?? {}),
  emit(json) {
    window.mmd.last = json;
    dispatchEvent(new CustomEvent("mmd-status", { detail: json }));
  },
};
