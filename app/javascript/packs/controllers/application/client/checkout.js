import { data } from "jquery";
import Raicon from "raicon";
import StripeController from "./stripe";
import { Ajax, popupFire, redirect } from "../../lib/application";

export default class CheckoutController {
  api = {
    infoCheckout: "/checkout/info_checkout",
    payment: "/checkout/payment",
    voucher: "/checkout/voucher",
    change_address: "/user/addresses/change_address",
  };

  voucher = { checked: false, code: "", cost: 0 };
  shipping = 0;

  total = 0;

  // ======================== Address ===================
  handleChange = () => {
    $("body").on("click", ".btn-confirm_address", () => {
      const checked = $("input[name=address]").filter(":checked").val();

      Ajax(this.api.change_address, "POST", { change_address: checked })
        .done((res) => {
          if (res.status === 200) {
            Swal.fire(
              {
                position: "center",
                icon: "success",
                title: "The Address has been changed successfully",
                showConfirmButton: false,
                timer: 1000,
              },
              setTimeout(() => {
                location.reload();
              }, 1000)
            );
          }
        })
        .fail();
    });
  };

  //  ================== Voucher =========================
  applyVoucher = () => {
    $("body").on("click", ".btn-apply", ({ target }) => {
      const voucher = $("input[name=apply_voucher]").val();

      if (voucher.trim().length !== 0) {
        Ajax(this.api.voucher, "POST", { voucher: voucher })
          .done((res) => {
            if (res.status == 200) {
              if (res.result) {
                popupFire("center", "success", res.message, 1500);
                this.voucher.checked = true;
                this.voucher.cost = res.cost;
                this.voucher.code = voucher;

                this.total = this.total - res.cost;

                $("#sale_price").html(`- $${res.cost}`);
                $("#total_price").html(`$${this.total}`);
              } else {
                popupFire("center", "error", res.message, 1500);
              }
            }
          })
          .fail((res) => {});
      } else {
        popupFire("center", "error", "Voucher is incorrect", 1500);
        return;
      }
    });
  };

  checkInputVoucher = () => {
    $("body").on("input", ".apply_voucher", ({ target }) => {
      const value = $(target).val();

      if (value != "") {
        $(".btn-apply_voucher").addClass("btn-apply");
      } else {
        $(".btn-apply_voucher").removeClass("btn-apply");
      }
    });
  };

  methodPayment = () => {
    $("body").on("click", ".into_money-btn", ({ target }) => {
      const carts = $.cookie("add_to_cart");
      const paymentGateway = $("input[name=payment_gateway]")
        .filter(":checked")
        .val();

      if (carts == [] || carts == undefined) {
        popupFire("center", "success", "Cart empty!", 1000);
        redirect("/", 1000);
        return;
      }

      if (paymentGateway == undefined) {
        popupFire("center", "error", "Please enter Payment Method !", 1500);
        return;
      }

      const data = {
        cart: carts,
        payment_gateway: paymentGateway,
        shipping: this.shipping,
        voucher: this.voucher.code,
      };

      Ajax(this.api.payment, "POST", data)
        .done((res) => {
          if (res.status === 200) {
            console.log(res);
            if (res.data.method == "STRIPE") {
              $(".home-page").replaceWith(res.data.html);
              const stripe = new StripeController(
                this.shipping,
                this.voucher.code
              );
            }

            if (res.data.method == "COD") {
              $.removeCookie("add_to_cart", { path: "/" });
              this.resetCart();
              $(".home-page").replaceWith(res.data.html);
            }

            if (res.data.method == "MOMO") {
              redirect(res.data.url);
              $.removeCookie("add_to_cart", { path: "/" });
            }
          } else {
            redirect("/checkout/error");
            redirect("/", 5000);
          }
        })
        .fail((res) => {});
    });
  };

  // =============== Stripe ======================

  // ============= Shipping ======================
  handleInputAddress = () => {
    $(".back_address, .change_address").on("click", () => {
      $(".address_content").toggle();
      $(".list-address_content").toggle();
    });
  };

  shippingCharge = () => {
    if ($("#transport_fee").length != 0) {
      Ajax(this.api.infoCheckout, "POST")
        .done((res) => {
          if (res.status == 200) {
            const temporaryPrice = parseFloat(res.data.total).toFixed(2);
            const feeShipping = res.data.fee.toFixed(2);
            this.shipping = feeShipping;
            this.total = (temporaryPrice - feeShipping).toFixed(2);

            $("#charge_fee").html(`$${feeShipping}`);
            $("#total_price").html(`$${this.total}`);
          } else {
            popupFire("center", "error", res.message, 2000);
            redirect("/", 2000);
          }
        })
        .fail((res) => {});
    }
  };

  // ================ Set up ==================

  resetCart = () => {
    $(".count-product").get(0).innerText = "";
    $("#loader").css("display", "flex");
    setTimeout(() => {
      $("#loader").css("display", "none");
    }, 1000);
  };

  show = () => {
    document.addEventListener("raicon:after:checkouts#show", () => {
      this.applyVoucher();
      this.checkInputVoucher();
      this.methodPayment();
      this.shippingCharge();
      this.handleInputAddress();
      this.handleChange();
    });
  };
}

Raicon.register("checkouts", CheckoutController);
