import { data } from "jquery";
import { Ajax } from "../../lib/application";
import Raicon from "raicon";

export default class AddressController {
  apiGHN = {
    token: "cbd8025f-55e4-11ed-ad26-3a4226f77ff0",
    province:
      "https://online-gateway.ghn.vn/shiip/public-api/master-data/province",
    district:
      "https://online-gateway.ghn.vn/shiip/public-api/master-data/district",
    ward: "https://online-gateway.ghn.vn/shiip/public-api/master-data/ward",
  };

  api = {
    change_address: "/user/addresses/change_address",
    deleteAddress: (item) => {
      return `/user/addresses/${item}`;
    },
  };

  getApiProvince = () => {
    $("#address_province").select2({
      placeholder: "Select your province",
    });

    Ajax(this.apiGHN.province, "GET", {}, { token: this.apiGHN.token })
      .done((res) => {
        const province = res.data;

        province.forEach((res) => {
          $("#address_province").append(
            $("<option>", {
              value: res.NameExtension[1],
              text: res.NameExtension[1],
              id: res.ProvinceID,
            })
          );
        });
      })
      .fail((res) => {});
  };

  getApiDistrict = () => {
    $("#address_district").select2({
      placeholder: "Select your district",
      disabled: true,
    });

    $("body").on("change", "#address_province", ({ target }) => {
      const province = $(target).find("option").filter(":selected");
      const provinceID = province.attr("id");
      province.after(
        `<input name="address[province_id]" value="${provinceID}" hidden >`
      );

      Ajax(
        this.apiGHN.district,
        "GET",
        { province_id: parseInt(provinceID) },
        { token: this.apiGHN.token }
      )
        .done((res) => {
          $("#address_district").prop("disabled", false);

          const district = res.data;

          let html =
            "<option disabled='' selected='' value=''>Select your district</option>";

          district.forEach((res) => {
            html =
              html.concat(` <option value='${res.DistrictName}' id='${res.DistrictID}'>${res.DistrictName}</option>
           `);
          });

          $("#address_district").empty().append(html);
        })
        .fail((res) => {});
    });
  };

  getApiWard = () => {
    $("#address_ward").select2({
      placeholder: "Select your district",
      disabled: true,
    });

    $("body").on("change", "#address_district", ({ target }) => {
      const district = $(target).find("option").filter(":selected");
      const districtID = district.attr("id");
      district.after(
        `<input name="address[district_id]" value="${districtID}" hidden >`
      );

      Ajax(
        this.apiGHN.ward,
        "GET",
        { district_id: parseInt(districtID) },
        { token: this.apiGHN.token }
      )
        .done((res) => {
          $("#address_ward").prop("disabled", false);
          const ward = res.data;
          let html =
            "<option disabled='' selected='' value=''>Select your ward</option>";
          ward.forEach((res) => {
            html =
              html.concat(` <option value='${res.WardName}' id='${res.WardCode}'>${res.WardName}</option>
               `);
          });
          $("#address_ward").empty().append(html);
        })
        .fail((res) => {});
    });
  };

  appendWard = () => {
    $("body").on("change", "#address_ward", ({ target }) => {
      const ward = $(target).find("option").filter(":selected");
      const wardID = ward.attr("id");
      ward.after(`<input name="address[ward_id]" value="${wardID}" hidden >`);
    });
  };

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

  handleDelete = () => {
    $("body").on("click", ".destroy_address", ({ target }) => {
      const item = $(target).closest(".item").find("input[name=address]").val();

      Swal.fire({
        title: "Do you want to remove address?",
        showDenyButton: true,
        confirmButtonText: "ok!",
        denyButtonText: `No`,
      }).then((result) => {
        if (result.isConfirmed) {
          Ajax(this.api.deleteAddress(item), "DELETE")
            .done((res) => {
              if (res.status === 200) {
                Swal.fire(
                  {
                    position: "center",
                    icon: "success",
                    title: "Remove successfully!",
                    showConfirmButton: false,
                    timer: 1000,
                  },
                  setTimeout(() => {
                    location.reload();
                  }, 1000)
                );
              } else {
                Swal.fire("there was an error in the process!", "", "error");
              }
            })
            .fail();
        } else if (result.isDenied) {
          Swal.fire("Changes are not saved", "", "info");
        }
      });
    });
  };

  handleInputAddress = () => {
    $(".back_address, .change_address").on("click", () => {
      $(".address_content").toggle();
      $(".list-address_content").toggle();
    });
  };

  action = () => {
    this.getApiProvince();
    this.getApiDistrict();
    this.getApiWard();
    this.appendWard();
    this.handleChange();
    this.handleInputAddress();
    this.handleDelete();
  };

  index = () => {
    this.action();
  };

  new = () => {
    this.action();
  };

  create = () => {
    this.action();
  };

  edit = () => {
    this.action();
  };

  update = () => {
    this.action();
  };

  destroy = () => {
    this.action();
  };

  index = () => {
    this.action();
  };

  show = () => {
    document.addEventListener(`raicon:after:checkouts#show`, () => {
      this.handleChange();
    });
  };
}

Raicon.register("addresses", AddressController);
