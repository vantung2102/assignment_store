const handleSelectInput = () => {
  $(".input_select2").select2({
    maximumSelectionLength: 10,
  });
};

const handleSelectInputTag = () => {
  $(".input_select2_tag").select2({
    tags: true,
    maximumSelectionLength: 10,
  });
};

const handleSelectAttributes = () => {
  $(document).on("click", ".add_fields", function () {
    $(".input_select2_tag").select2({
      tags: true,
      maximumSelectionLength: 10,
    });
  });
};

const handleClickSidebar = () => {
  $(".navbar-toggler.navbar-toggler").on("click", function () {
    var body = $("body");
    body.toggleClass("sidebar-icon-only");
  });

  $(".nav-link").on("click", function () {
    $(this)
      .closest(".nav-item.nav-category")
      .find(".panel-collapse.collapse")
      .toggleClass("show");
  });
};

document.addEventListener("turbolinks:load", () => {
  handleSelectInput();
  handleSelectInputTag();
  handleSelectAttributes();
  handleClickSidebar();
});
