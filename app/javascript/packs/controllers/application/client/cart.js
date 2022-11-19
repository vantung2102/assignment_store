import { data } from "jquery";
import "../../lib/jquery.cookie";
import {
  actionController,
  Ajax,
  changeUrl,
  redirect,
} from "../../lib/application";
import Raicon from "raicon";

export default class CartController {
  api = {
    checkAmount: "/cart/check_amount",
    getProduct: "/cart/select_attribute",
    showCart: "/cart/show_cart",
  };

  constructor() {
    this.showIconCart();
    this.handleSendCart();
  }

  setCart = (data) => {
    $.cookie.json = true;
    $.cookie("add_to_cart", data, { path: "/" });
  };

  getCart = () => {
    $.cookie.json = true;
    return $.cookie("add_to_cart") ? $.cookie("add_to_cart") : [];
  };

  showIconCart = () => {
    const carts = this.getCart();
    $(".count-product").get(0).innerText =
      carts?.length > 0 ? carts.length : "";
  };

  handleSendCart = () => {
    $("body").on("click", ".sendCart", () => {
      const carts = this.getCart();

      if (carts.length != 0) {
        Ajax(this.api.showCart, "GET", { carts: carts })
          .done((res) => {
            if (res.status == 200) {
              $("#slider").remove();
              $(".home-page").replaceWith(res.html);
              changeUrl("/cart/show_cart");
            }
          })
          .fail((res) => {});
      } else {
        redirect("/cart/show_cart");
      }
    });
  };

  handleDelete = () => {
    $("body").on("click", ".cart_quantity_delete", ({ target }) => {
      const item = $(target).closest(".list-cart");
      const id = item.attr("id").split("_")[0];
      const item_attr1 = item.find(".item_attr1");
      const item_attr2 = item.find(".item_attr2");

      let cart = this.getCart();

      if (item_attr1.length == 1 && item_attr2.length == 1) {
        const value_attr1 = item_attr1.attr("id").split("_")[1];
        const value_attr2 = item_attr2.attr("id").split("_")[1];

        cart = cart.filter(
          (res) =>
            res.id != id ||
            value_attr1 != res.val_1.toString() ||
            value_attr2 != res.val_2.toString()
        );
      } else if (item_attr1.length == 1 && item_attr2.length == 0) {
        const value_attr1 = item_attr1.attr("id").split("_")[1];

        cart = cart.filter((res) => res.id != id || value_attr1 != res.val_1);
      } else {
        cart = cart.filter((res) => res.id != id);
      }

      Swal.fire({
        title: "Do you want to remove item?",
        showDenyButton: true,
        confirmButtonText: "ok!",
        denyButtonText: `No`,
      }).then((result) => {
        if (result.isConfirmed) {
          if (cart.length == 0) {
            $.removeCookie("add_to_cart", { path: "/" });
          } else {
            this.setCart(cart);
          }

          item.remove();
          this.showIconCart();
          redirect("/cart/show_cart");
          Swal.fire("Remove successfully!", "", "success");
        } else if (result.isDenied) {
          Swal.fire("Changes are not saved", "", "info");
        }
      });
    });
  };

  handleIncrease = () => {
    $("body").on("click", ".cart_quantity_up", ({ target }) => {
      const item = $(target).closest(".list-cart");
      const id = item.attr("id").split("_")[0];
      const input = item.find("input");
      const oldQuantity = input.val();
      const newQuantity = parseInt(oldQuantity) + 1;

      input.val(parseInt(oldQuantity) + 1);

      const carts = this.getCart();

      const item_attr1 = item.find(".item_attr1");
      const item_attr2 = item.find(".item_attr2");

      if (item_attr1.length == 1 && item_attr2.length == 1) {
        const value_attr1 = item_attr1.attr("id").split("_")[1];
        const value_attr2 = item_attr2.attr("id").split("_")[1];

        const data = {
          id: id,
          id_attr1: item_attr1.attr("id").split("_")[0],
          value_attr1: item_attr1.attr("id").split("_")[1],
          id_attr2: item_attr2.attr("id").split("_")[0],
          value_attr2: item_attr2.attr("id").split("_")[1],
        };

        const itemCart = carts.find(
          (res) =>
            res.id === id &&
            value_attr1 == res.val_1 &&
            value_attr2 == res.val_2
        );
        Ajax(this.api.checkAmount, "GET", { cart: data })
          .done((res) => {
            if (res.status == 200) {
              if (res.data.stock < newQuantity) {
                Swal.fire(
                  "Sorry, the quantity you purchased is larger than the quantity in stock.",
                  "",
                  "error"
                );
                input.val(1);
                this.setCartAgain(itemCart, carts, 1);
              } else {
                this.setCartAgain(itemCart, carts, newQuantity);
                item
                  .find(".cart_total_price")
                  .html(
                    (res.data.price_attribute_product - res.product.discount) *
                      newQuantity
                  );
              }
            }
          })
          .fail((res) => {});
      } else if (item_attr1.length == 1 && item_attr2.length == 0) {
        const value_attr1 = item_attr1.attr("id").split("_")[1];

        const data = {
          id: id,
          id_attr1: item_attr1.attr("id").split("_")[0],
          value_attr1: item_attr1.attr("id").split("_")[1],
        };

        const itemCart = carts.find(
          (res) => res.id === id && value_attr1 == res.val_1
        );

        Ajax(this.api.checkAmount, "GET", { cart: data })
          .done((res) => {
            if (res.status == 200) {
              if (res.data.stock < newQuantity) {
                Swal.fire(
                  "Sorry, the quantity you purchased is larger than the quantity in stock.",
                  "",
                  "error"
                );
                input.val(1);
                this.setCartAgain(itemCart, carts, 1);
              } else {
                this.setCartAgain(itemCart, carts, newQuantity);
                item
                  .find(".cart_total_price")
                  .html(
                    (res.data.price_attribute_product - res.product.discount) *
                      newQuantity
                  );
              }
            }
          })
          .fail((res) => {});
      } else {
        const itemCart = carts.find((res) => res.id === id);

        Ajax(this.api.checkAmount, "GET", { cart: { id: id } })
          .done((res) => {
            if (res.status == 200) {
              if (res.product.quantity < newQuantity) {
                Swal.fire(
                  "Sorry, the quantity you purchased is larger than the quantity in stock.",
                  "",
                  "error"
                );
                input.val(1);
                this.setCartAgain(itemCart, carts, 1);
              } else {
                this.setCartAgain(itemCart, carts, newQuantity);
                item
                  .find(".cart_total_price")
                  .html(
                    (res.product.price_cents - res.product.discount) *
                      newQuantity
                  );
              }
            }
          })
          .fail((res) => {});
      }
    });
  };

  handleDecrease = () => {
    $("body").on("click", ".cart_quantity_down", ({ target }) => {
      const item = $(target).closest(".list-cart");
      const id = item.attr("id").split("_")[0];
      const input = item.find("input");
      const quantity = input.val();

      let cart = this.getCart();

      const item_attr1 = item.find(".item_attr1");
      const item_attr2 = item.find(".item_attr2");

      if (parseInt(quantity) == 1) {
        if (item_attr1.length == 1 && item_attr2.length == 1) {
          const value_attr1 = item_attr1.attr("id").split("_")[1];
          const value_attr2 = item_attr2.attr("id").split("_")[1];

          cart = cart.filter(
            (res) =>
              res.id != id ||
              value_attr1 != res.val_1 ||
              value_attr2 != res.val_2
          );
        } else if (item_attr1.length != 1 || item_attr2.length != 0) {
          const value_attr1 = item_attr1.attr("id").split("_")[1];
          cart = cart.filter((res) => res.id != id || value_attr1 != res.val_1);
        } else {
          cart = cart.filter((res) => res.id != id);
        }

        Swal.fire({
          title: "Do you want to remove item?",
          showDenyButton: true,
          confirmButtonText: "ok!",
          denyButtonText: `No`,
        }).then((result) => {
          if (result.isConfirmed) {
            item.remove();
            this.setCart(cart);
            this.showIconCart();

            Swal.fire("Remove successfully!", "", "success");
          } else if (result.isDenied) {
            Swal.fire("Changes are not saved", "", "info");
          }
        });
      } else {
        input.val(parseInt(quantity) - 1);
        const newQuantity = parseInt(quantity) - 1;
        const total = item.find(".cart_total_price");

        if (item_attr1.length == 1 && item_attr2.length == 1) {
          const value_attr1 = item_attr1.attr("id").split("_")[1];
          const value_attr2 = item_attr2.attr("id").split("_")[1];

          const itemCart = cart.find(
            (res) =>
              res.id === id &&
              value_attr1 == res.val_1 &&
              value_attr2 == res.val_2
          );
          this.setCartAgain(itemCart, cart, newQuantity);

          total.html((parseFloat(total.html()) / quantity) * newQuantity);
        } else if (item_attr1.length == 1 && item_attr2.length == 0) {
          const value_attr1 = item_attr1.attr("id").split("_")[1];
          const itemCart = cart.find(
            (res) => res.id === id && value_attr1 == res.val_1
          );
          this.setCartAgain(itemCart, cart, newQuantity);
          total.html((parseFloat(total.html()) / quantity) * newQuantity);
        } else {
          const itemCart = cart.find((res) => res.id === id);
          this.setCartAgain(itemCart, cart, newQuantity);
          total.html((parseFloat(total.html()) / quantity) * newQuantity);
        }
      }
    });
  };

  handleInputChange = () => {
    $("body").on("change", ".cart_quantity_input", ({ target }) => {
      const value = $(target).val();

      if (value > 0) {
        const item = $(target).closest(".list-cart");
        const id = item.attr("id").split("_")[0];
        const carts = this.getCart();
        const Item = carts.find((res) => res.id === id);

        if (Item) {
          Item.amount = value;
          this.setCart(carts);
        }
      } else {
        $(target).val("1");
      }
    });
  };

  setCartAgain = (itemCart, cart, amount) => {
    if (itemCart) {
      itemCart.amount = amount;
      this.setCart(cart);
    }
  };

  getTotalCart = () => {
    const cart = this.getCart();
    let total = cart.reduce((sum, res) => sum + parseInt(res.amount), 0);
    return total;
  };

  action = () => {
    this.handleDelete();
    this.handleIncrease();
    this.handleDecrease();
    this.handleInputChange();
  };

  show = () => {
    actionController("show", "cart", this.action());
  };
}

Raicon.register("cart", CartController);
