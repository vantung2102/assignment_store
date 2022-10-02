import "../lib/bootstrap.min";
import "../lib/select2.min";

import Main from "./home/main";
import Home from "./home/home";
import Comment from "./client/comment";
import Cart from "./client/cart";
import Order from "./client/order";

document.addEventListener("turbolinks:load", () => {
  const main = new Main();
  const home = new Home();
  const comment = new Comment();
  const cart = new Cart();
  const order = new Order();
});
