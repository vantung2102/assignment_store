import { data } from "jquery";

export default class Order {
  constructor() {
    this.getApiProvince();
    this.getApiDistrict();
    this.getApiWard();
    this.applyVoucher();
  }

  getApiProvince = () => {
    $("#order_province").select2({
      placeholder: "Select your province",
    });

    $.ajax({
      url: "https://vapi.vnappmob.com/api/province",
      type: "GET",
      dataType: "json",
      success: (response) => {
        const province = response.results;

        province.forEach((res) => {
          $("#order_province").append(
            $("<option>", {
              value: res.province_id,
              text: res.province_name,
            })
          );
        });
      },
      error: (response) => {},
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

          const district = response.results;
          let html =
            "<option disabled='' selected='' value=''>Select your district</option>";

          district.forEach((res) => {
            html =
              html.concat(` <option value='${res.district_id}'>${res.district_name}</option>
           `);
          });

          $("#order_district").empty().append(html);
        },
        error: (response) => {},
      });
    });
  };

  getApiWard = () => {
    $("#order_ward").select2({
      placeholder: "Select your district",
      disabled: true,
    });

    $("body").on("change", "#order_district", ({ target }) => {
      const district = $(target).find("option").filter(":selected").val();

      $.ajax({
        url: `https://vapi.vnappmob.com/api/province/ward/${district}`,
        type: "GET",
        dataType: "json",
        success: (response) => {
          $("#order_ward").prop("disabled", false);

          const district = response.results;
          let html =
            "<option disabled='' selected='' value=''>Select your ward</option>";

          district.forEach((res) => {
            html =
              html.concat(` <option value='${res.ward_id}'>${res.ward_name}</option>
           `);
          });

          $("#order_ward").empty().append(html);
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
}
