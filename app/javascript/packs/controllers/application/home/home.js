const getUrlParameter = (sParam) => {
  var sPageURL = window.location.search.substring(1),
    sURLVariables = sPageURL.split("&"),
    sParameterName,
    i;

  for (i = 0; i < sURLVariables.length; i++) {
    sParameterName = sURLVariables[i].split("=");

    if (sParameterName[0] === sParam) {
      return sParameterName[1] === undefined
        ? true
        : decodeURIComponent(sParameterName[1]);
    }
  }
  return false;
};

export default class Home {
  constructor() {
    this.handleChangeCategory();
    this.handleLoadCategory();
    this.handleChangeBrand();
    this.handleLoadMore();
  }

  handleChangeCategory = () => {
    $("body").on("click", ".category", function () {
      const slug = $(this).attr("id").split("_")[0];
      const category = $(this);

      $.ajax({
        url: "category/" + slug,
        type: "GET",
        beforeSend: function (xhr) {
          xhr.setRequestHeader(
            "X-CSRF-Token",
            $('meta[name="csrf-token"]').attr("content")
          );
        },
        data: { slug: slug },
        dataType: "json",
        success: function (response) {
          if (response.status == 200) {
            $(".category").removeClass("active");
            category.addClass("active");
            $(".features_items").replaceWith(response.html);
            $(".btn-load_more").hide();
            const url = "?category=" + slug;
            window.history.pushState({}, "", url);
          }
        },
        error: function (response) {},
      });
    });
  };

  handleLoadCategory = () => {
    const panel = $(".panel.panel-default").find(".category.active");
    if (panel) {
      panel.closest(".panel-collapse").addClass("in");
    }
  };

  handleChangeBrand = () => {
    $(".brand__item").on("click", function () {
      const brand = $(this);
      const slug = $(this).attr("id").split("_")[0];

      $.ajax({
        url: "brand/" + slug,
        type: "GET",
        beforeSend: function (xhr) {
          xhr.setRequestHeader(
            "X-CSRF-Token",
            $('meta[name="csrf-token"]').attr("content")
          );
        },
        data: { slug: slug },
        dataType: "json",
        success: function (response) {
          if (response.status == 200) {
            console.log(122);
            $(".brand__item").removeClass("active");
            brand.addClass("active");
            $(".features_items").replaceWith(response.html);
            $(".btn-load_more").hide();
            const url = "?brand=" + slug;
            window.history.pushState({}, "", url);
          }
        },
        error: function (response) {},
      });
    });
  };

  handleLoadMore = () => {
    $(".btn-load_more").on("click", function () {
      $("#loader").css("display", "flex");

      const page =
        getUrlParameter("page") === false ? 1 : getUrlParameter("page");

      $.ajax({
        url: "product/load_more",
        type: "GET",
        beforeSend: function (xhr) {
          xhr.setRequestHeader(
            "X-CSRF-Token",
            $('meta[name="csrf-token"]').attr("content")
          );
        },
        data: { page: page },
        dataType: "json",
        success: function (response) {
          if (response.status == 200) {
            console.log(response.page);
            if (response.page != "error_page") {
              $(".features_items").append(response.html);
              const next_page = parseInt(page) + 1;
              const url = "?page=" + next_page;
              window.history.pushState({}, "", url);

              if (response.page == "last_page") {
                $(".load_more").hide();
              } else {
                $(".load_more").show();
              }
            } else if (response.page == "error_page") {
              window.history.pushState({}, "", "?page=1");
            }

            setTimeout(function () {
              $("#loader").css("display", "none");
            }, 200);
          }
        },
        error: function (response) {},
      });
    });
  };
}
