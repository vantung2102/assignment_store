function Home(options) {
  var module = this;

  module.handleChangeCategory = function () {
    $(document).on("click", ".category", function () {
      const slug = $(this).attr("id").split("_")[0];
      const category = $(this);

      $.ajax({
        url: "category=" + slug,
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
            console.log(category);
            $(".category").removeClass("active");
            category.addClass("active");

            $(".features_items").replaceWith(response.html);

            window.history.pushState(
              { html: response.html },
              "",
              "?category=" + slug
            );
            console.log(window.history);
          }
        },
        error: function (response) {},
      });
    });
  };

  module.handleLoad = function () {};

  module.init = function () {
    module.handleChangeCategory();
  };
}

$(document).ready(function () {
  home = new Home();
  home.init();
});
