import { logger } from "@rails/actioncable";
import Raicon from "raicon";
import { Ajax } from "../../lib/application";

export default class ProductController {
  api = {
    showNoAttribute: "/admin/products/show_no_attribute",
  };
  constructor() {
    this.handleImageProductInput();
    this.inputImageAttributeValue();
    this.showAddAttribute();
    this.closeAddAttribute();
    this.showAddAttribute2();
    this.closeAddAttribute2();
    this.handleInputAttribute();
    this.handleInputAttribute2();
    this.handleInputEmpty();
    this.addListAttribute();
    this.addListAttribute2();
    this.handleShowTitle();
    this.appendAttribute();
    this.deleteAttribute1();
    this.deleteAttribute2();
    this.beforeUpdateDestroy();
    this.beforeUpdateInsert();
  }

  handleImageProductInput = () => {
    $("body").on("change", "#product_images", ({ target, event }) => {
      event.preventDefault();
      const $preview = $(".preview");
      $(".preview").empty();

      const newFiles = $(target).prop("files");

      if (newFiles) $.each(newFiles, readAndPreview);

      function readAndPreview(index, file) {
        if (!/\.(jpe?g|png|gif)$/i.test(file.name)) {
          Swal.fire({
            position: "top-center",
            icon: "error",
            title: "File is not an image",
            showConfirmButton: false,
            timer: 2000,
          });
          return;
        }

        const reader = new FileReader();

        $(reader).on("load", ({ target }) => {
          $preview.append(
            $("<img/>", {
              src: target.result,
              class: "img-thumbnail",
            })
          );
        });

        reader.readAsDataURL(file);
      }
    });
  };

  inputImageAttributeValue = () => {
    $("body").on("change", ".input_image_val", ({ target, event }) => {
      const $img_val = $(target).closest(".label_image_value").find(".img_val");
      const file = $(target)
        .closest(".label_image_value")
        .find(".input_image_val")[0].files[0];

      $img_val.empty();

      if (file == undefined) {
        $(target).closest(".label_image_value").find(".add_image_value").show();
        return;
      }

      if (!/\.(jpe?g|png|gif)$/i.test(file.name)) {
        Swal.fire({
          position: "top-center",
          icon: "error",
          title: "File is not an image",
          showConfirmButton: false,
          timer: 2000,
        });
        return;
      }

      const image = new FileReader();

      $(image).on("load", ({ target }) => {
        $img_val.append(
          $("<img/>", {
            src: target.result,
            class: "img-thumbnail",
          }).attr("aria-hidden", "false")
        );
      });
      image.readAsDataURL(file);

      $img_val.show();
      if ($img_val.html().length == 0)
        $(target).closest(".label_image_value").find(".add_image_value").hide();
    });
  };

  showAddAttribute = () => {
    $("body").on("click", ".btn-add__attribute", () => {
      $.ajax({
        url: "/admin/products/show_attribute",
        type: "POST",
        beforeSend: (xhr) => {
          xhr.setRequestHeader(
            "X-CSRF-Token",
            $('meta[name="csrf-token"]').attr("content")
          );
        },
        dataType: "json",
        success: (response) => {
          if (response.status == 200) {
            $(".product-edit__section").replaceWith(response.html);
          }
        },
        error: (response) => {},
      });
    });
  };

  closeAddAttribute = () => {
    $("body").on("click", ".options-close-btn", () => {
      Ajax(this.api.showNoAttribute, "POST")
        .done((res) => {
          if (res.status == 200) {
            $(".product-edit__section").replaceWith(res.html);
          }
        })
        .fail((res) => {});
    });
  };

  showAddAttribute2 = () => {
    $("body").on("click", ".btn-add__attribute-2", () => {
      $.ajax({
        url: "/admin/products/show_attribute2",
        type: "POST",
        beforeSend: (xhr) => {
          xhr.setRequestHeader(
            "X-CSRF-Token",
            $('meta[name="csrf-token"]').attr("content")
          );
        },
        dataType: "json",
        success: (response) => {
          if (response.status == 200) {
            $(".variation-add-2").replaceWith(response.html);
            $(".header_title_attr1").after(`
              <div class="table-cell table-header d-flex header_title_attr2 border-start-0" style="background-color: #f5f5f5;">
                <div class="popover-cell-content tittle_2"> Attribute 2 </div>
              </div>
            `);
            $(".variation-header").append(this.htmlInfoAttr2());
          }
        },
        error: (response) => {},
      });
    });
  };

  closeAddAttribute2 = () => {
    $("body").on("click", ".options-close-btn2", () => {
      $(".attribute-2").replaceWith(this.variationAdd2());
      $(".table-cell2").remove();
      $(".header_title_attr2").remove();

      const htmlPriceAndStock = this.htmlPriceAndStock({
        height: "129px",
        isValid: false,
      });
      const html = `
      <div class="variation-warp" data-price-stock=1>
      ${htmlPriceAndStock}
      `;

      $(".variation-warp").replaceWith(html);
    });
  };

  handleInputAttribute = () => {
    $("body").on("click", ".add_attribute", () => {
      let data =
        parseInt($(".variation-header:last").data("indexAttribute")) + 1;

      const htmlInput = this.htmlInput({
        index: data,
        isValid: false,
      });
      $(".variation-edit-right.d-flex:last").after(htmlInput);

      const htmlImage = this.htmlImage(data);

      $(".variation-model-table-body.variation-header:last").after(htmlImage);

      const htmlPriceAndStock = this.htmlPriceAndStock({
        height: "129px",
        isValid: false,
      });

      if ($(".attribute2").length == 0) {
        // only attr 1
        const dataPriceStock = parseInt(
          $(".variation-warp:last").data("price-stock")
        );

        $(".variation-warp:last").after(
          `<div class='variation-warp' data-price-stock=${
            dataPriceStock + 1
          }>` +
            htmlPriceAndStock +
            "</div>"
        );
      } else {
        // have attr2

        // $(".variation-warp:last").after(
        //   '<div class="variation-warp">' +
        //     $(".variation-warp:last").html() +
        //     "</div>"
        // );
        // $(".table-cell2-content:last").replaceWith(
        //   $(".table-cell2-content:first").html()
        // );

        const wrapper = $(".second-variation-wrapper:last");

        const html =
          `<div class="table-cell table-cell2 table-cell2-content border-top-0">
               <div class="second-variation-wrapper">` +
          wrapper.html() +
          `</div>
          </div>`;

        const dataPriceStock = parseInt(
          $(".variation-warp:last").data("price-stock")
        );
        $(".variation-header:last").append(html);
        $(".variation-warp:last").after(
          `<div class='variation-warp' data-price-stock=${
            dataPriceStock + 1
          }>` +
            $(".variation-warp:last").html() +
            "</div>"
        );
      }

      // have attr1 and attr2 add firstly
      if ($(".table-cell2").find("d-flex").length == 1) {
        $(".variation-warp:last").after(htmlPriceAndStock);
      }
    });
  };

  handleInputAttribute2 = () => {
    $("body").on("click", ".add_attribute2", () => {
      let data =
        parseInt(
          $(".attribute2:last").closest(".variation-edit-right2").data("index")
        ) + 1;

      const htmlBody = `
      <div class="d-flex" data-body-attr2=2>
        <div class="table-cell align-items-center border-top-0 border-bottom-0" data-index-attr2=${data} style="min-height: 64px;"></div>
      </div>
    `;

      const htmlPriceAndStock = this.htmlPriceAndStock({
        height: "64px",
        isValid: false,
        dataItem: 1,
      });

      if ($(".attribute2").length == 1) {
        $(".second-variation-wrapper").find(".d-flex").replaceWith(`
          <div class="d-flex" data-body-attr2=1>
            <div class="table-cell align-items-center border-top-0" data-index-attr2=${1} style="min-height: 65px;"></div>
          </div>
        `);
        $(".second-variation-wrapper").find(".d-flex:last").after(htmlBody);

        $(".variation-model-table-body.variation-body").replaceWith(
          htmlPriceAndStock
        );

        const dataPrice = $(".variation-body:last").data("item-price");
        const htmlDataPrice = this.htmlPriceAndStock({
          height: "64px",
          isValid: false,
          dataItem: dataPrice + 1,
        });
        $(".variation-warp").append(htmlDataPrice);
      } else {
        const data = parseInt(
          $(".second-variation-wrapper").find(".d-flex:last").data("body-attr2")
        );
        $(".second-variation-wrapper").append(`
          <div class="d-flex" data-body-attr2=${data + 1}>
            <div class="table-cell align-items-center border-bottom-0" data-index-attr2=${data} style="min-height: 65px;"></div>
          </div>
        `);

        // $(".variation-model-table-body.variation-body").replaceWith(
        //   htmlPriceAndStock
        // );

        const dataPrice = $(".variation-body:last").data("item-price");
        const htmlDataPrice = this.htmlPriceAndStock({
          height: "64px",
          isValid: false,
          dataItem: dataPrice + 1,
        });
        $(".variation-warp").find(".variation-body:last").after(htmlDataPrice);
      }
      const htmlInput = this.htmlInputAttr2({ index: data, isValid: false });
      $(".variation-edit-right2.d-flex:last").after(htmlInput);
    });
  };

  handleInputEmpty = () => {
    $("body").on("input", ".input_attribute-product", ({ target }) => {
      const currTarget = $(target);
      const valueTarget = currTarget.val();

      const errorBlank = `
        <div class="product-edit-form-item-error">
          Không được để trống ô
        </div>
      `;
      const errorMatch = `
        <div class="product-edit-form-item-error2">
          Không được nhap trung nhau
        </div>
      `;

      if (valueTarget == "") {
        const findErrorBlank = currTarget
          .closest(".product_title")
          .find(".product-edit-form-item-error");

        if (findErrorBlank.length == 0) {
          const html = document.createElement("div");
          $(html)
            .addClass("product-edit-form-item-error")
            .html("Không được để trống ô");

          currTarget.css("border-color", "#ff4742");

          currTarget.after(html);

          currTarget
            .closest(".product_title")
            .find(".product-edit-form-item-error2")
            .remove();
        }
      } else {
        currTarget.css("border-color", "#ccc");

        currTarget
          .closest(".form-group")
          .find(".product-edit-form-item-error")
          .remove();

        if ($(".input_attribute-product").length > 1) {
          const arrayInput = $(".input_attribute-product").not(currTarget);

          arrayInput.toArray().forEach((el) => {
            if ($(el).val().length > 0) {
              if (valueTarget == $(el).val()) {
                const findErrorMatchTarget = currTarget
                  .closest(".form-group")
                  .find(".product-edit-form-item-error2");

                const findErrorMatchElement = $(el)
                  .closest(".form-group")
                  .find(".product-edit-form-item-error2");

                if (findErrorMatchTarget.length == 0)
                  currTarget.after(errorMatch);

                if (findErrorMatchElement.length == 0) $(el).after(errorMatch);
              } else {
                currTarget
                  .closest(".form-group")
                  .find(".product-edit-form-item-error2")
                  .remove();

                if ($(".product-edit-form-item-error2").length == 1)
                  $(".product-edit-form-item-error2").remove();
              }
            }
          });
        }
      }
    });
  };

  addListAttribute = () => {
    $("body").on("input", ".input_attribute-product", ({ target }) => {
      const currTarget = $(target);

      const data = currTarget
        .closest(".variation-edit-right.d-flex")
        .data("index");

      const variation_header = $(`[data-index-attribute=${data}]`);

      variation_header.find(".table-cell__content").html(currTarget.val());
    });
  };

  addListAttribute2 = () => {
    $("body").on("input", ".attribute2", ({ target }) => {
      const currTarget = $(target);
      const data = currTarget.closest(".variation-edit-right2").data("index");
      const variation_header = $(`[data-index-attr2=${data}]`);

      variation_header.html(currTarget.val());
    });
  };

  handleShowTitle = () => {
    $("body").on("input", ".title_attribute_1", ({ target }) => {
      $(".tittle_1").html($(target).val());
    });

    $("body").on("input", ".title_attribute_2", ({ target }) => {
      $(".tittle_2").html($(target).val());
    });
  };

  appendAttribute = () => {
    const url = window.location.href.split("/");
    const length = url.length;

    const edit = url[length - 1];

    if (edit == "edit") {
      const id = url[length - 2];

      $.ajax({
        url: `/admin/products/${id}/edit_product`,
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
          console.log(response);
          if (response.status == 200) {
            if (response.data != undefined) {
              const attributes = response.data.attributes;
              const values = response.data.value;
              const images = response.data.images;

              if (attributes.length == 0) {
              } else if (attributes.length == 1) {
                $(".product-edit__section").replaceWith(response.html.attr1);

                $(".title_attribute_1")
                  .val(attributes[0].name)
                  .addClass("is-valid");
                $(".tittle_1").html(attributes[0].name);

                values.map((item, index) => {
                  const htmlInput = this.htmlInput({
                    index: index + 1,
                    value: item.attribute_1,
                    isValid: true,
                  });
                  $(".variation-edit-right.d-flex:last").after(htmlInput);

                  const htmlImage = this.htmlImage(
                    index + 1,
                    images[index],
                    item.attribute_1
                  );
                  $(".variation-header:last").after(htmlImage);

                  const htmlPriceAndStock = this.htmlPriceAndStock({
                    price: item.price_attribute_product,
                    stock: item.stock,
                    height: "129px",
                    dataItem: 1,
                    isValid: true,
                  });

                  // $(".variation-warp:last").after(
                  //   $("<div>", { class: "variation-warp" })
                  // );

                  $(".variation-warp:last").after(
                    $("<div>", { class: "variation-warp" }).attr(
                      "data-price-stock",
                      index + 1
                    )
                  );

                  $(".variation-warp:last").append(htmlPriceAndStock);
                });
                $(".variation-edit-right.d-flex:first").remove();
                $(".variation-header:first").remove();
                $(".variation-warp:first").remove();
              } else {
                $(".product-edit__section").replaceWith(response.html.attr1);
                $(".variation-add-2").replaceWith(response.html.attr2);
                $(".header_title_attr1").after(`
                  <div class="table-cell table-header d-flex header_title_attr2 border-start-0" style="background-color: #f5f5f5;">
                    <div class="popover-cell-content tittle_2"> Attribute 2 </div>
                  </div>
                `);
                $(".variation-header").append(this.htmlInfoAttr2());
                $(".title_attribute_1")
                  .val(attributes[0].name)
                  .addClass("is-valid");
                $(".tittle_1").html(attributes[0].name);
                $(".title_attribute_2")
                  .val(attributes[1].name)
                  .addClass("is-valid");
                $(".tittle_2").html(attributes[1].name);
                const attribute_value_1 = [
                  ...new Set(values.map((item) => item.attribute_1)),
                ];

                const attribute_value_2 = [
                  ...new Set(values.map((item) => item.attribute_2)),
                ];

                attribute_value_1.map((item, index) => {
                  const htmlInput = this.htmlInput({
                    index: index + 1,
                    value: item,
                    isValid: true,
                  });
                  $(".variation-edit-right.d-flex:last").after(htmlInput);
                  const htmlImage = this.htmlImage(
                    index + 1,
                    images[index],
                    item
                  );
                  $(".variation-header:last").after(htmlImage);

                  $(".variation-warp:last").after(
                    $("<div>", { class: "variation-warp" }).attr(
                      "data-price-stock",
                      index + 1
                    )
                  );
                });
                $(".variation-edit-right.d-flex:first").remove();
                $(".variation-header:first").remove();
                let i = 1;
                let count = 0;
                values.map((item, index) => {
                  if (count == parseInt(attribute_value_2.length)) {
                    i += 1;
                    count = 0;
                  }
                  count += 1;
                  const htmlPriceAndStock = this.htmlPriceAndStock({
                    price: item.price_attribute_product,
                    stock: item.stock,
                    height: "64px",
                    isValid: true,
                    dataItem: count,
                  });
                  $(`[data-price-stock=${i}]`).append(htmlPriceAndStock);
                });

                $(".variation-warp:first").remove();
                $(".variation-header").find(".d-flex").after(`
                  <div class="table-cell table-cell2 table-cell2-content border-top-0">
                    <div class="second-variation-wrapper">
                    </div>
                  </div>
                `);
                attribute_value_2.map((item, index) => {
                  const html = this.htmlInputAttr2({
                    index: index + 1,
                    value: item,
                    isValid: true,
                  });
                  $(".variation-edit-right2.d-flex:last").after(html);
                  $(".second-variation-wrapper").append(`
                    <div class="d-flex" data-body-attr2=${index + 1}>
                      <div class="table-cell align-items-center border-top-0" data-index-attr2="${(index += 1)}" style="min-height: 65px;">${item}</div>
                    </div>`);
                });
                $(".second-variation-wrapper")
                  .find(".d-flex:last")
                  .find(".table-cell")
                  .addClass("border-bottom-0");
                $(".variation-edit-right2.d-flex:first").remove();
              }
            }
          }
        },
        error: (response) => {},
      });
    }
  };

  deleteAttribute1 = () => {
    $("body").on("click", ".btn_delete_attr1", ({ target }) => {
      if ($(".btn_delete_attr1").length == 1) {
        Ajax(this.api.showNoAttribute, "POST")
          .done((res) => {
            if (res.status == 200) {
              $(".product-edit__section").replaceWith(res.html);
            }
          })
          .fail((res) => {});
      }
      const inputAttribute = $(target).closest(".variation-edit-right");
      const index = inputAttribute.data("index");

      inputAttribute.remove();
      $(`[data-index-attribute=${index}]`).remove();
      $(`[data-price-stock=${index}]`).remove();
    });
  };

  deleteAttribute2 = () => {
    $("body").on("click", ".btn_delete_attr2", ({ target }) => {
      if ($(".btn_delete_attr2").length == 1) {
        $(".attribute-2").replaceWith(this.variationAdd2());
        $(".table-cell2").remove();
        $(".header_title_attr2").remove();
        $(".variation-body").find(".table-cell").css("min-height", "130px");

        return;
      } else {
        const inputAttribute = $(target).closest(".variation-edit-right2");
        const index = inputAttribute.data("index");

        if ($(".btn_delete_attr2").length == 2) {
          $(".second-variation-wrapper")
            .find(".table-cell")
            .css("min-height", "130px");

          $(".variation-body").find(".table-cell").css("min-height", "130px");
        }

        inputAttribute.remove();
        $(`[data-body-attr2=${index}]`).remove();
        $(`[data-item-price=${index}]`).remove();
        // $(".second-variation-wrapper")
        //   .find(".table-cell")
        //   .addClass("border-bottom-0");
        $(".variation-body").find(".table-cell").css("min-height", "65px");
        $(".variation-warp").find(".table-cell:last").css("min-height", "66px");
        if (
          $(".second-variation-wrapper:last").find(".table-cell").length == 1
        ) {
          $(".variation-body").find(".table-cell").css("min-height", "131px");
        }
      }
    });
  };

  beforeUpdateDestroy = () => {
    const url = window.location.href.split("/");
    const length = url.length;

    const edit = url[length - 1];

    if (edit == "edit") {
      const id = url[length - 2];

      $("body").on(
        "click",
        ".btn_delete_attr1, .btn_delete_attr2",
        ({ target }) => {
          const val = $(target)
            .closest(".variation-edit-right-content")
            .find("input")
            .val();

          $("<input>")
            .attr({
              type: "hidden",
              id: val,
              name: "product[update][destroy][attribute_value][]",
              value: val,
            })
            .appendTo("form");
        }
      );
    }
  };

  beforeUpdateInsert = () => {
    const url = window.location.href.split("/");
    const length = url.length;

    const edit = url[length - 1];

    if (edit == "edit") {
      const id = url[length - 2];

      $("body").on("click", ".add_attribute, .add_attribute2", ({ target }) => {
        if ($("#insert_attribute").length == 0) {
          $("<input>")
            .attr({
              type: "hidden",
              id: "insert_attribute",
              name: "product[update][insert]",
              value: "action",
            })
            .appendTo("form");
        }
      });
    }
  };

  // ========================== Support UI ==========================

  htmlInfoAttr2 = () => {
    const html = `
      <div class="table-cell table-cell2 table-cell2-content border-top-0">
        <div class="second-variation-wrapper">
          <div class="d-flex" data-body-attr2=1>
            <div class="table-cell align-items-center border-top-0 border-bottom-0" data-index-attr2="1" style="min-height: 128px;"></div>
          </div>
        </div>
      </div>        
    `;
    return html;
  };

  htmlInput = ({
    index: index,
    value: value,
    isValid: boolean,
    idProduct: id,
  }) => {
    const html = `
      <div class="variation-edit-right d-flex" data-index=${index}>
        <div class="variation-edit-right-content">
          <div class="form-group string optional product_product_attribute_values_attribute_1">
            <input class="form-control string optional input_attribute-product ${
              boolean == true ? "is-valid" : ""
            }" multiple="multiple" 
            placeholder="example: red, blue v.v" type="text" 
            name="product[product_attribute_1][attribute_value][attribute][]" 
            id="product_product_attribute_1_attribute_value_attribute_1 ${
              id == undefined ? "" : id
            }" value="${value == undefined ? "" : value}">
          </div>
          <div>
            <i class="fa-solid fa-trash btn_delete_attr1"></i>
          </div>
        </div>
      </div>
    `;
    return html;
  };

  htmlInputAttr2 = ({ index: index, value: value, isValid: boolean }) => {
    const html = ` 
      <div class="variation-edit-right2 d-flex" data-index=${index}>
        <div class="variation-edit-right-content">
          <div class="form-group string optional product_product_attribute_values_attribute_2">
            <input class="form-control ${
              boolean == true ? "is-valid" : ""
            } string optional attribute2" multiple="multiple" 
            name="product[product_attribute_2][attribute_value][attribute][]" 
            id="product_product_attribute_2_attribute_value_attribute_2" placeholder="example: red, blue v.v" type="text" value="${
              value == undefined ? "" : value
            }">
          </div>
        
          <div>
            <i class="fa-solid fa-trash btn_delete_attr2"></i>
          </div>
        </div>
      </div>
    `;

    return html;
  };

  htmlImage = (index, img, content) => {
    const html = `
      <div class="variation-model-table-body d-flex variation-header" data-index-attribute=${index}>
        <div class="d-flex">
          <div class="table-cell content-img border-top-0">
            <div class="table-cell__content">${
              content == undefined ? "" : content
            }</div>
            <div class="container-image-manager display-flex">
              <label for="product_product_attribute_1_images_${index}" class="label_image_value">
                  <i aria-hidden="true" class="fa-regular fa-image add_image_value" style="display:${
                    img == undefined ? "block" : "none"
                  }"></i>
                  <div class="img_val" style="display:${
                    img == undefined ? "none" : "block"
                  }">
                    <img class="img-thumbnail" style="display:${
                      img == undefined ? "none" : "block"
                    }" 
                    aria-hidden="false" src="${img == undefined ? "" : img}">
                  </div>
                  <input class="form-control file optional input_image_val" 
                  id="product_product_attribute_1_images_${index}"
                  name="product[product_attribute_1][images][]" style="display:none" type="file">
                  <i class="fa-sharp fa-solid fa-circle-plus"></i>
                </label>
            </div>
          </div>
        </div>
      </div>
    `;
    return html;
  };

  htmlPriceAndStock = ({
    price: price,
    stock: stock,
    height: height,
    isValid: boolean,
    dataItem: data,
  }) => {
    const html = `
    <div class="variation-model-table-body d-flex variation-body" data-item-price=${data}>
      <div class="table-cell flex-grow-1 content-price" style="min-height:${height}">
        <div class="popover-wrap d-flex align-items-center" style="min-height:${height}">
          <div class="form-group float optional product_product_attribute_values_price_attribute_product">
            <input class="form-control numeric float optional ${
              boolean == true ? "is-valid" : ""
            }" multiple="multiple" 
            placeholder="Enter price" type="number" step="any" 
            name="product[product_attribute_1][attribute_value][price_attribute_product][]" 
            id="product_product_attribute_1_attribute_value_price_attribute_product"
            value="${price}">
          </div>
        </div>
      </div>
      <div class="table-cell flex-grow-1 content-stock border-top-0" style="min-height:${height}">
        <div class="popover-wrap d-flex align-items-center" style="min-height:${height}">
          <div class="form-group integer optional product_product_attribute_values_stock">
            <input class="form-control numeric integer optional ${
              boolean == true ? "is-valid" : ""
            }" multiple="multiple" 
            placeholder="Enter amount stock" type="number" step="1" 
            name="product[product_attribute_1][attribute_value][stock][]" 
            id="product_product_attribute_1_attribute_value_stock"
            value="${stock}">
          </div>
        </div>
      </div>
    </div>
    `;

    return html;
  };

  variationAdd2 = () => {
    const html = `
      <div class="variation-add-2">
        <div class="variation-add-2-left">Classification group 2</div>
        <div class="variation-add-2-right">
          <button class="btn-add__attribute-2" type="button">
            <i class="fa-solid fa-plus"></i>
            <span>Add classification group 2</span>
          </button>
        </div>
      </div>`;
    return html;
  };
}

// Raicon.register("admin/products", ProductController);
