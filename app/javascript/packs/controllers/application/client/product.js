import { data } from "jquery";
import Raicon from "raicon";
import "../../lib/slick";
import "../../lib/jquery.cookie";
import CommentController from "./comment";

import { Ajax, getLocale, popupFire } from "../../lib/application";

export default class ProductController {
  locale = getLocale();

  api = {
    checkAmount: "/cart/check_amount",
    getProduct: "/cart/select_attribute",
    showCart: "/cart/show_cart",
  };

  handleSliderSlick = () => {
    $(".pro-dec-big-img-slider").slick({
      slidesToShow: 1,
      slidesToScroll: 1,
      arrows: false,
      draggable: false,
      fade: false,
      asNavFor: ".product-dec-slider-small",
    });

    $(".product-dec-slider-small").slick({
      slidesToShow: 3,
      slidesToScroll: 1,
      asNavFor: ".pro-dec-big-img-slider",
      dots: false,
      focusOnSelect: true,
      fade: false,
      prevArrow:
        '<a class="left item-control"><i class="fa fa-angle-left"></i></a>',
      nextArrow:
        '<a class="right item-control"><i class="fa fa-angle-right"></i></a>',
    });

    $(".item-control:not(.slick-arrow)")
      .closest(".slick-slide:not(.slick-cloned)")
      .remove();
  };

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

  checkInput = () => {
    $("body").on("input", ".numberInput", (e) => {
      if (
        typeof parseInt($(e.target).val()) == "string" ||
        parseInt($(e.target).val()) <= 0
      ) {
        $(e.target).val(1);
        return;
      }
    });
  };

  checkAttribute = () => {
    const attribute = $(".attribute_product").css("display");
    if (attribute == "none") $(".attribute_product").remove();
  };

  clickAttribute = () => {
    $("body").on("click", ".attribute_item", ({ target }) => {
      const attribute = $(target);
      const attributeOld = $(target).closest(".select__items").find(".active");
      const attributeDanger = $(".attribute_error");

      if (attribute.hasClass("active") == false) attribute.addClass("active");
      else attribute.removeClass("active");

      if (attributeOld.length != 0) attributeOld.removeClass("active");

      if (attributeDanger.length != 0) {
        attributeDanger.remove();
        $(".attribute_product").css("background-color", "#fff");
      }

      if ($(".select__items").length == 2) {
        if ($(".select__items").find(".active").length == 2) {
          const data = {
            id_attr1: $(".item1.active").data("attribute"),
            value_attr1: $(".item1.active").html(),
            id_attr2: $(".item2.active").data("attribute"),
            value_attr2: $(".item2.active").html(),
          };

          Ajax(this.api.getProduct, "GET", { data: data })
            .done((res) => {
              if (res.status == 200) {
                $(".price_new").replaceWith(
                  `<span class="price_new">${res.value.price_attribute_product}</span>`
                );
                if (parseInt(res.value.stock) > 0) {
                  $(".out-of-stock").replaceWith(` 
                    <a class="btn btn-fefault cart add-to-cart" name="add-to-cart-detail">
                      <i class="fa fa-shopping-cart"></i> 
                      Add to cart
                    </a>
                  `);
                  $(".product__stock").replaceWith(` 
                    <p class="product__stock"><b>Quantity in stock: </b> ${res.value.stock} </p>
                  `);
                } else {
                  $(".product__stock").replaceWith(` 
                    <p class="product__stock"><b>Quantity in stock: </b> 0 </p>
                  `);
                  $(".add-to-cart").replaceWith(` 
                    <a class="btn btn-danger out-of-stock" href="javascript:void(0)">Out of stock</a>
                  `);
                }
              }
            })
            .fail((res) => {});

          // $.ajax({
          //   url: "/cart/select_attribute",
          //   type: "GET",
          //   data: { data: data },
          //   beforeSend: (xhr) => {
          //     xhr.setRequestHeader(
          //       "X-CSRF-Token",
          //       $('meta[name="csrf-token"]').attr("content")
          //     );
          //   },
          //   dataType: "json",
          //   success: (response) => {
          //     if (response.status == 200) {
          //       $(".price_new").replaceWith(
          //         `<span class="price_new">${response.value.price_attribute_product}</span>`
          //       );
          //       if (parseInt(response.value.stock) > 0) {
          //         $(".out-of-stock").replaceWith(`
          //           <a class="btn btn-fefault cart add-to-cart" name="add-to-cart-detail">
          //             <i class="fa fa-shopping-cart"></i>
          //             Add to cart
          //           </a>
          //         `);
          //         $(".product__stock").replaceWith(`
          //           <p class="product__stock"><b>Quantity in stock: </b> ${response.value.stock} </p>
          //         `);
          //       } else {
          //         $(".product__stock").replaceWith(`
          //           <p class="product__stock"><b>Quantity in stock: </b> 0 </p>
          //         `);
          //         $(".add-to-cart").replaceWith(`
          //           <a class="btn btn-danger out-of-stock" href="javascript:void(0)">Out of stock</a>
          //         `);
          //       }
          //     }
          //   },
          //   error: (response) => {},
          // });
        }
      } else if ($(".select__items").length == 1) {
        const data = {
          id_attr1: $(".item1.active").data("attribute"),
          value_attr1: $(".item1.active").html(),
        };

        Ajax(this.api.getProduct, "GET", { data: data })
          .done((res) => {
            if (res.status == 200) {
              $(".product__stock").replaceWith(` 
                <p class="product__stock"><b>Quantity in stock: </b>${res.value.stock}</p>
              `);

              $(".price_new").replaceWith(
                `<span class="price_new">${res.value.price_attribute_product}</span>`
              );
            }
          })
          .fail((res) => {});

        // $.ajax({
        //   url: "/cart/select_attribute",
        //   type: "GET",
        //   data: { data: data },
        //   beforeSend: (xhr) => {
        //     xhr.setRequestHeader(
        //       "X-CSRF-Token",
        //       $('meta[name="csrf-token"]').attr("content")
        //     );
        //   },
        //   dataType: "json",
        //   success: (response) => {
        //     if (response.status == 200) {
        //       $(".product__stock").replaceWith(`
        //         <p class="product__stock"><b>Quantity in stock: </b>${response.value.stock}</p>
        //       `);

        //       $(".price_new").replaceWith(
        //         `<span class="price_new">${response.value.price_attribute_product}</span>`
        //       );
        //     }
        //   },
        //   error: (response) => {},
        // });
      }
    });
  };

  checkAttributeAddCart = () => {
    const amountAttribute = $(".select__items").length;
    const amountAttributeItem = $(".attribute_item.active").length;

    if (amountAttribute != amountAttributeItem) {
      if ($(".attribute_error").length == 0) {
        $(".attribute_product").css("background-color", "#fff5f5");

        const html = document.createElement("div");
        $(html)
          .addClass("attribute_error")
          .html("Please select attribute product")
          .appendTo($(".attribute_product .item"));
      }

      return false;
    }
    return true;
  };

  handleAddCart = () => {
    $("body").on("click", ".add-to-cart", ({ target }) => {
      if (this.checkAttributeAddCart() == true) {
        let carts = this.getCart();

        const product = $(target).closest(".add_product");
        const id = product.attr("id").split(" ")[0];
        const amount = parseInt($(".numberInput").val());

        if ($(".select__items").length == 0) {
          const addItem = carts.find((res) => res.id === id);
          if (addItem) {
            addItem.amount = parseInt(addItem.amount) + 1;
          } else {
            const data = {
              id: id,
              amount: 1,
            };

            Ajax(this.api.checkAmount, "GET", { cart: data })
              .done((res) => {
                if (res.status == 200) {
                  if (addItem) {
                    if (
                      parseInt(addItem.amount) + amount >
                      parseInt(res.data.stock)
                    ) {
                      Swal.fire(
                        "Sorry, the quantity is larger than the quantity in stock.",
                        "",
                        "error"
                      );
                    } else {
                      addItem.amount = parseInt(addItem.amount) + amount;
                      this.setCart(carts);
                    }
                  } else {
                    if (amount > res.product.quantity) {
                      Swal.fire(
                        "Sorry, the quantity is larger than the quantity in stock.",
                        "",
                        "error"
                      );
                    } else {
                      const data = {
                        id: id,
                        amount: amount,
                      };
                      carts.push(data);
                      this.setCart(carts);
                      this.showIconCart();

                      popupFire(
                        "top-right",
                        "success",
                        "The product has been added successfully",
                        2000
                      );
                    }
                  }
                }
              })
              .fail((res) => {});
          }
        } else if ($(".select__items").length == 1) {
          const id_attr1 = $(".item1.active").data("attribute");
          const value_attr1 = $(".item1.active").html();

          const data = {
            id_attr1: id_attr1,
            value_attr1: value_attr1,
          };

          const addItem = carts.find(
            (res) => res.id === id && value_attr1 == res.val_1
          );

          Ajax(this.api.checkAmount, "GET", { cart: data })
            .done((res) => {
              if (res.status == 200) {
                if (addItem) {
                  if (
                    parseInt(addItem.amount) + amount >
                    parseInt(res.data.stock)
                  ) {
                    Swal.fire(
                      "Sorry, the quantity is larger than the quantity in stock.",
                      "",
                      "error"
                    );
                  } else {
                    addItem.amount = parseInt(addItem.amount) + amount;
                    this.setCart(carts);
                  }
                } else {
                  if (amount > res.data.stock) {
                    Swal.fire(
                      "Sorry, the quantity is larger than the quantity in stock.",
                      "",
                      "error"
                    );
                  } else {
                    const data = {
                      id: id,
                      amount: amount,
                      id_1: id_attr1,
                      val_1: value_attr1,
                    };
                    carts.push(data);
                    this.setCart(carts);
                    this.showIconCart();

                    popupFire(
                      "top-right",
                      "success",
                      "The product has been added successfully",
                      2000
                    );
                  }
                }
              }
            })
            .fail((res) => {});
        } else {
          const id_attr1 = $(".item1.active").data("attribute");
          const id_attr2 = $(".item2.active").data("attribute");
          const value_attr1 = $(".item1.active").html();
          const value_attr2 = $(".item2.active").html();

          const data = {
            id_attr1: id_attr1,
            value_attr1: value_attr1,
            id_attr2: id_attr2,
            value_attr2: value_attr2,
          };

          const addItem = carts.find(
            (res) =>
              res.id === id &&
              value_attr1 == res.val_1 &&
              value_attr2 == res.val_2
          );

          Ajax(this.api.checkAmount, "GET", { cart: data })
            .done((res) => {
              if (res.status == 200) {
                if (addItem) {
                  if (parseInt(addItem.amount) + 1 > parseInt(res.stock)) {
                    Swal.fire(
                      "Sorry, the quantity is larger than the quantity in stock.",
                      "",
                      "error"
                    );
                  } else {
                    addItem.amount = parseInt(addItem.amount) + 1;
                    this.setCart(carts);
                  }
                } else {
                  const data = {
                    id: id,
                    amount: 1,
                    id_1: id_attr1,
                    val_1: value_attr1,
                    id_2: id_attr2,
                    val_2: value_attr2,
                  };
                  carts.push(data);
                  this.setCart(carts);
                  this.showIconCart();

                  popupFire(
                    "top-right",
                    "success",
                    "The product has been added successfully",
                    2000
                  );
                }
              }
            })
            .fail((res) => {});
        }
      }
    });
  };

  show = () => {
    document.addEventListener("raicon:after:productDetail#show", () => {
      this.handleSliderSlick();
      this.checkInput();
      this.checkAttribute();
      this.clickAttribute();
      this.handleAddCart();
      const comment = new CommentController();
    });
  };
}

Raicon.register("productDetail", ProductController);
