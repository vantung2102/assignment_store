import "../lib/bootstrap.min";
import Main from "./home/main";
import Home from "./home/home";
import Comment from "./client/comment";

document.addEventListener("turbolinks:load", () => {
  const main = new Main();
  const home = new Home();
  const comment = new Comment();
});
