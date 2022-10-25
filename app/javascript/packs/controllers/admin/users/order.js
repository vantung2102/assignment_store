export default class Order {
  constructor() {
    this.submitOrder();
    this.cancelOrder();
    this.orderSuccess();
  }

  submitOrder = () => {
    $("body").on("click", ".submitOrder", ({ target }) => {
      const id = $(target).closest("tr").attr("id");
      $.ajax({
        url: "/admin/orders/submit",
        type: "POST",
        beforeSend: (xhr) => {
          xhr.setRequestHeader(
            "X-CSRF-Token",
            $('meta[name="csrf-token"]').attr("content")
          );
        },
        data: { id: id },
        dataType: "json",
        success: (response) => {
          if (response.status == 200) {
            Swal.fire({
              position: "top-right",
              icon: "success",
              title: "Submit order successfully",
              showConfirmButton: false,
              timer: 2000,
            });

            setTimeout(() => {
              Turbolinks.visit("/admin/orders");
            }, 2000);
          }
        },
        error: (response) => {},
      });
    });
  };

  cancelOrder = () => {
    $("body").on("click", ".cancelOrder", ({ target }) => {
      const id = $(target).closest("tr").attr("id");
      $.ajax({
        url: "/admin/orders/cancel",
        type: "POST",
        beforeSend: (xhr) => {
          xhr.setRequestHeader(
            "X-CSRF-Token",
            $('meta[name="csrf-token"]').attr("content")
          );
        },
        data: { id: id },
        dataType: "json",
        success: (response) => {
          if (response.status == 200) {
            Swal.fire({
              position: "top-right",
              icon: "success",
              title: "Cancel order successfully",
              showConfirmButton: false,
              timer: 1000,
            });

            setTimeout(() => {
              Turbolinks.visit("/admin/orders");
            }, 1000);
          }
        },
        error: (response) => {},
      });
    });
  };

  orderSuccess = () => {
    $("body").on("click", ".orderSuccess", ({ target }) => {
      const id = $(target).closest("tr").attr("id");
      $.ajax({
        url: "/admin/orders/success",
        type: "POST",
        beforeSend: (xhr) => {
          xhr.setRequestHeader(
            "X-CSRF-Token",
            $('meta[name="csrf-token"]').attr("content")
          );
        },
        data: { id: id },
        dataType: "json",
        success: (response) => {
          if (response.status == 200) {
            Swal.fire({
              position: "top-right",
              icon: "success",
              title: "Order successfully",
              showConfirmButton: false,
              timer: 1000,
            });

            setTimeout(() => {
              Turbolinks.visit("/admin/orders");
            }, 1000);
          }
        },
        error: (response) => {},
      });
    });
  };
}
