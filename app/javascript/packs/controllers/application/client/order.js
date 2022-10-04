import { data } from "jquery";

export default class Order {
  constructor() {
    this.getApiProvince();
    this.getApiDistrict();
    this.getApiWard();
    this.applyVoucher();
    this.inputAddress();
    this.createAddress();
  }

  appendOption = (data, str) => {
    data.forEach((res) => {
      $(`#order_${str}`).append(
        $("<option>", {
          value: res[`${str}_id`],
          text: res[`${str}_name`],
        })
      );
    });
  };

  getApiProvince = () => {
    $("#order_province").select2({
      placeholder: "Select your province",
    });

    $.ajax({
      url: "http://vapi.vnappmob.com/api/province",
      type: "GET",
      dataType: "json",
      contentType: "application/json",
      success: (response) => {
        console.log(665);
        const provinces = response.results;
        this.appendOption(provinces, "province");
      },
      error: (response) => {},
    });

    $("body").on("change", "#order_province", () => {
      $("#order_ward").empty();
      $("#order_district").empty();
    });
  };

  getApiDistrict = () => {
    $("#order_district").select2({
      placeholder: "Select your district",
      disabled: true,
    });

    $("body").on("change", "#order_province", ({ target }) => {
      const province = $(target).find("option").filter(":selected").val();

      $.ajax({
        url: `https://vapi.vnappmob.com/api/province/district/${province}`,
        type: "GET",
        dataType: "json",
        success: (response) => {
          $("#order_district").prop("disabled", false);
          const districts = response.results;
          this.appendOption(districts, "district");
        },
        error: (response) => {},
      });
    });
  };

  getApiWard = () => {
    $("#order_ward").select2({
      placeholder: "Select your ward",
      disabled: true,
    });

    $("body").on("change", "#order_district", ({ target }) => {
      const district = $(target).find("option").filter(":selected").val();

      $.ajax({
        url: `https://vapi.vnappmob.com/api/province/ward/${district}`,
        type: "GET",
        dataType: "json",
        success: (response) => {
          $("#order_ward").empty();
          $("#order_ward").prop("disabled", false);
          const wards = response.results;
          this.appendOption(wards, "ward");
        },
        error: (response) => {},
      });
    });
  };

  applyVoucher = () => {
    $("body").on("input", ".apply_voucher", ({ target }) => {
      const value = $(target).val();

      if (value != "") {
        $(".btn-apply_voucher").addClass("btn-apply");
      } else {
        $(".btn-apply_voucher").removeClass("btn-apply");
      }
    });
  };

  inputAddress = () => {
    $(".back_address, .change_address").on("click", () => {
      $(".address_content").toggle();
      $(".list-address_content").toggle();
    });
  };

  createAddress = () => {
    // invalid-feedback
    // $(".create_address").on("click", () => {
    //   const name = $("#address_fullname").val();
    //   const phone = $("#address_phone_number").val();
    //   const province = $("#order_province")
    //     .find("option")
    //     .filter(":selected")
    //     .val();
    //   const district = $("#order_district")
    //     .find("option")
    //     .filter(":selected")
    //     .val();
    //   const ward = $("#order_ward").find("option").filter(":selected").val();
    //   const addressDetail = $("#address_addressDetail").val();
    //   if(name=='')
    // });
  };
}
