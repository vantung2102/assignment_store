import { data } from "jquery";
import Raicon from "raicon";
import { Ajax, changeUrl, redirect } from "../../lib/application";

export default class OrderController {
  api = {
    orderDetail: "/user/order/detail",
    refundStripe: "/checkout/refund_stripe",
  };

  orderDetail = () => {
    $("body").on("click", ".item_order-body", ({ target }) => {
      const code = $(target).closest(".item_order-body").attr("id");

      Ajax(this.api.orderDetail, "POST", { code: code })
        .done((res) => {
          if (res.status == 200) {
            $(".user_col_right").replaceWith(res.html);
            changeUrl(`/user/order/detail/${code}`);
          }
        })
        .fail((res) => {});
    });
  };

  refund = () => {
    $("body").on("click", ".btn-refund", ({ target }) => {
      const code = $(target).attr("id");

      Swal.fire({
        title: "Are you sure you want to cancel your order?",
        showDenyButton: true,
        confirmButtonText: "ok!",
        denyButtonText: `No`,
      }).then((result) => {
        if (result.isConfirmed) {
          Ajax(this.api.refundStripe, "POST", { code: code })
            .done((res) => {
              if (res.status == 200) {
                Swal.fire("Refund successfully!", "", "success");

                redirect(`/user/order/detail/${code}`, 1000);
              }
            })
            .fail((res) => {});
        } else {
          Swal.fire("Changes are not saved", "", "info");
        }
      });
    });
  };

  show = () => {
    this.orderDetail();
    this.refund();
  };

  showOrderDetail = () => {
    document.addEventListener(`raicon:after:orders#showOrderDetail`, () => {
      this.refund();
    });
  };
}

Raicon.register("orders", OrderController);
