import React from "react";
import ReactDOM  from "react-dom";
import "jquery";
import "popper.js/dist/umd/popper"
import "bootstrap";
import "./styles/index.css"
import "bootstrap/dist/css/bootstrap.css"
import App from "./app";
import { BrowserRouter } from "react-router-dom";

var element = <button class="btn btn-danger">Hello World</button>
ReactDOM.render(
   
        <App/>,

    document.getElementById("root")
);