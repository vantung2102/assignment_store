const handleChangeCategory = () => {
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
          const url = "?category=" + slug;
          window.history.pushState({}, "", url);
        }
      },
      error: function (response) {},
    });
  });
};

const handleLoadCategory = () => {
  const panel = $(".panel.panel-default").find(".category.active");
  if (panel) {
    panel.closest(".panel-collapse").addClass("in");
  }
};

document.addEventListener("turbolinks:load", () => {
  handleChangeCategory();
  handleLoadCategory();
});
