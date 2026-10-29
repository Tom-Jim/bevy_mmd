import { createRoot } from "react-dom/client";
import { App } from "./App";
import { connect } from "./host";
import "./style.css";

connect().then((host) => createRoot(document.getElementById("ui-root")!).render(<App host={host} />));
