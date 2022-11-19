import Turbolinks from "turbolinks";
import "../../lib/jquery.cookie";
import { Ajax, redirect } from "../../lib/application";

export default class StripeController {
  publicKey =
    "pk_test_51LpSrFHh49tj9otcfpX0avnxrpcyZ2ymmqs4H3rXkl3nsdpcehThIr15ifYyKstVk6f4ezRl0yd0O27DDkRCAEYX00NhGPglqM";

  stripe = Stripe(this.publicKey, {
    apiVersion: "2022-08-01",
  });

  api = {
    paymentWithStripe: "/checkout/payment_with_stripe",
    checkOrderStripe: "/checkout/check_order_stripe",
  };

  setInterval = null;

  constructor(shipping, voucher) {
    this.styleStripe(shipping, voucher);
  }

  styleStripe = (shipping, voucher) => {
    $("#btn_payment").prop("disabled", true);

    const elements = this.stripe.elements();

    const style = {
      base: {
        color: "#32325d",
        fontFamily: "Arial, sans-serif",
        fontSmoothing: "antialiased",
        fontSize: "16px",
        "::placeholder": {
          color: "#888",
        },
      },
      invalid: {
        fontFamily: "Arial, sans-serif",
        color: "#fa755a",
        iconColor: "#fa755a",
      },
    };

    const cardNumber = elements.create("cardNumber", {
      style: style,
      placeholder: "XXXX XXXX XXXX XXXX",
    });
    const cardExpiry = elements.create("cardExpiry", {
      style: style,
      placeholder: "MM / YY",
    });
    const cardCvc = elements.create("cardCvc", {
      style: style,
      placeholder: "CVC",
    });

    const card_number = document.getElementById("card_number");
    const card_day = document.getElementById("card_number");
    const card_cvc = document.getElementById("card_number");

    if (card_number && card_day && card_cvc) {
      cardNumber.mount("#card_number");
      cardExpiry.mount("#card_day");
      cardCvc.mount("#card_cvc");

      this.paymentWithStripe(cardNumber, shipping, voucher);

      this.errorInput(cardNumber, "#card_number-error");
      this.errorInput(cardExpiry, "#card_day-error");
    }
  };

  paymentWithStripe = (cardNumber, shipping, voucher) => {
    const data = {
      shipping: shipping,
      voucher: voucher,
    };
    Ajax(this.api.paymentWithStripe, "POST", data)
      .done((res) => {
        if (res.status === 200) {
          const form = document.getElementById("payment-form");

          form.addEventListener("submit", (e) => {
            e.preventDefault();
            this.payWithCard(this.stripe, cardNumber, res.data);
          });
        }
      })
      .fail((res) => {});
  };

  payWithCard = (stripe, cardNumber, data) => {
    this.loading(true);

    stripe
      .confirmCardPayment(data.key_secret.client_secret, {
        payment_method: {
          card: cardNumber,
          billing_details: {
            email: data.user.email,
          },
        },
      })
      .then((result) => {
        if (result.error) {
          this.showError(result.error.message);
        } else {
          this.loading(false);

          this.setInterval = setInterval(
            this.renderSuccess,
            5000,
            result.paymentIntent.id
          );
        }
      });
  };

  // refund = () => {
  //   $("body").on("click", ".btn-refund", ({ target }) => {
  //     const code = $(target).attr("id");

  //     Swal.fire({
  //       title: "Are you sure you want to cancel your order?",
  //       showDenyButton: true,
  //       confirmButtonText: "ok!",
  //       denyButtonText: `No`,
  //     }).then((result) => {
  //       if (result.isConfirmed) {
  //         Ajax(this.api.refundStripe, "POST", { code: code })
  //           .done((res) => {
  //             if (res.status == 200) {
  //               Swal.fire("Refund successfully!", "", "success");

  //               redirect(`/user/order/detail/${code}`, 1000);
  //             }
  //           })
  //           .fail((res) => {});

  //         Swal.fire("Changes are not saved", "", "info");
  //       }
  //     });
  //   });
  // };

  // ---------------- UI Helper -------------------
  renderSuccess = (payment_intent_id) => {
    Ajax(this.api.checkOrderStripe, "POST", {
      payment_intent_id: payment_intent_id,
    })
      .done((res) => {
        if (res.status == 200) {
          clearInterval(this.setInterval);
          $.removeCookie("add_to_cart", { path: "/" });
          $(".count-product").get(0).innerText = "";

          $("#loader").css("display", "flex");
          setTimeout(() => {
            $("#loader").css("display", "none");
          }, 1000);
          $(".home-page").replaceWith(res.html);
        }
      })
      .fail((res) => {});
  };

  orderComplete = () => {
    this.loading(false);
  };

  showError = (errorMsgText) => {
    this.loading(false);
    const errorMsg = document.querySelector("#card-error");

    errorMsg.textContent = errorMsgText;
    setTimeout(() => {
      errorMsg.textContent = "";
    }, 10000);
  };

  loading = (isLoading) => {
    if (isLoading) {
      $("#btn_payment").prop("disabled", true);
      document.querySelector("#spinner").classList.remove("hidden");
    } else {
      $("#btn_payment").prop("disabled", false);
      document.querySelector("#spinner").classList.add("hidden");
    }
  };

  errorInput = (card, element) => {
    const btn = $("#btn_payment");
    card.on("change", (e) => {
      if (e.error) {
        document.querySelector(element).textContent = e.error.message;
        btn.prop("disabled", true);
        btn.removeClass("apply");
      } else {
        btn.prop("disabled", false);
        btn.addClass("apply");
      }
    });
  };
}
