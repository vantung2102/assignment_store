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

// window.jQuery = window.$ = require("jquery");
// import "./stylesheet/application/application.scss";
// import "@fortawesome/fontawesome-free/css/all.css";
import "./stylesheet/application/common/_common";
import "./stylesheet/application/common/_animation.scss";

import "./stylesheet/application/layout/_header.scss";
import "./stylesheet/application/layout/_slider.scss";
import "./stylesheet/application/layout/_category.scss";
import "./stylesheet/application/layout/_login.scss";
import "./stylesheet/application/layout/_footer.scss";
