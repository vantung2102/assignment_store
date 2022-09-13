function Home(options) {
  var module = this;

  module.handleChangeCategory = function () {
    $(".category").on("click", function () {
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
            window.history.pushState({}, "", "?category=" + slug);
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
