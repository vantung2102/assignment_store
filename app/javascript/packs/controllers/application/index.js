import "../lib/bootstrap.min";
import "../lib/select2.min";
import "../../controllers/lib/jquery.cookie";

import "./home/home";
import "./client/user";
import "./client/product";
import "./client/comment";
import "./client/cart";
import "./client/address";
import "./client/checkout";
import "./client/order";

import MainController from "./home/main";

document.addEventListener("turbolinks:load", () => {
  const main = new MainController();
});
