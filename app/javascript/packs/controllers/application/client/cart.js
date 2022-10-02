import { data } from "jquery";
import "../../lib/jquery.cookie";

export default class Cart {
  constructor() {
    this.showIconCart();
    this.handleAddCart();
    this.handleSendCart();
    this.handleDelete();
    this.handleIncrease();
    this.handleDecrease();
    this.handleInputChange();
  }

  setCart = (data) => {
    $.cookie.json = true;
    $.removeCookie("add_to_cart");
    $.cookie("add_to_cart", data, { expires: 30 });
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

  handleAddCart = () => {
    let carts = this.getCart();

    $("body").on("click", ".add-to-cart", ({ target }) => {
      const product = $(target).closest(".add_product");
      const id = product.attr("id").split(" ")[0];

      const addItem = carts.find((res) => res.id === id);

      if (addItem) {
        addItem.quantity = parseInt(addItem.quantity) + 1;
      } else {
        const data = {
          id: id,
          quantity: 1,
        };

        carts.push(data);
      }

      this.setCart(carts);
      this.showIconCart();

      Swal.fire({
        position: "top-right",
        icon: "success",
        title: "The product has been added successfully",
        showConfirmButton: false,
        timer: 2000,
      });
    });
  };

  handleSendCart = () => {
    $("body").on("click", ".cart", () => {
      const carts = this.getCart();

      if (carts.length != 0) {
        $.ajax({
          url: "/cart/show_cart",
          type: "GET",
          beforeSend: (xhr) => {
            xhr.setRequestHeader(
              "X-CSRF-Token",
              $('meta[name="csrf-token"]').attr("content")
            );
          },
          data: { carts: carts },
          dataType: "json",
          success: (response) => {
            if (response.status == 200) {
              $("#slider").remove();
              $(".home-page").replaceWith(response.html);
              const page = window.location.pathname;

              if (page == "/") {
                window.history.replaceState({}, "", "cart/show_cart");
              }
            }
          },
          error: (response) => {},
        });
      } else {
        window.location.href = "/cart/show_cart";
      }
    });
  };

  handleDelete = () => {
    $("body").on("click", ".cart_quantity_delete", ({ target }) => {
      const item = $(target).closest(".list-cart");
      const id = item.attr("id").split("_")[0];

      let carts = this.getCart();
      carts = carts.filter((res) => res.id !== id);

      Swal.fire({
        title: "Do you want to remove item?",
        showDenyButton: true,
        confirmButtonText: "ok!",
        denyButtonText: `No`,
      }).then((result) => {
        if (result.isConfirmed) {
          if (carts.length == 0) {
            $.removeCookie("add_to_cart");
          } else {
            this.setCart(carts);
          }

          item.remove();
          this.showIconCart();
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
      input.val(parseInt(oldQuantity) + 1);

      const carts = this.getCart();
      const Item = carts.find((res) => res.id === id);

      if (Item) {
        Item.quantity++;
        this.setCart(carts);
      }
    });
  };

  handleDecrease = () => {
    $("body").on("click", ".cart_quantity_down", ({ target }) => {
      const item = $(target).closest(".list-cart");
      const id = item.attr("id").split("_")[0];
      const input = item.find("input");
      const quantity = input.val();

      let carts = this.getCart();

      if (parseInt(quantity) == 1) {
        carts = carts.filter((res) => res.id !== id);

        Swal.fire({
          title: "Do you want to remove item?",
          showDenyButton: true,
          showCancelButton: true,
          confirmButtonText: "ok!",
          denyButtonText: `No`,
        }).then((result) => {
          if (result.isConfirmed) {
            item.remove();
            this.setCart(carts);
            this.showIconCart();

            Swal.fire("Remove successfully!", "", "success");
          } else if (result.isDenied) {
            Swal.fire("Changes are not saved", "", "info");
          }
        });
      } else {
        const Item = carts.find((res) => res.id === id);
        input.val(parseInt(quantity) - 1);

        if (Item) {
          Item.quantity--;
          this.setCart(carts);
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
          Item.quantity = value;
          this.setCart(carts);
        }
      } else {
        $(target).val("1");
      }
    });
  };
}
