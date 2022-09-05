// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs";
import Turbolinks from "turbolinks";
import * as ActiveStorage from "@rails/activestorage";
import "channels";

Rails.start();
Turbolinks.start();
ActiveStorage.start();

window.jQuery = window.$ = require("jquery");
import "../../../node_modules/bootstrap/scss/bootstrap.scss";

import "../packs/controllers/admin";
// import "../packs/controllers/admin/users/helpers";
// import "../packs/controllers/admin/users/perfect-scrollbar";
// import "../packs/controllers/admin/users/menu";

// import "@fortawesome/fontawesome-free/css/all.css";
import "./stylesheet/admin/application.scss";
