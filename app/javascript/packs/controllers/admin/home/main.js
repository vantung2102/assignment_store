export default class MainController {
  constructor() {
    this.handleSelectInput();
    this.handleSelectInputTag();
    this.handleSelectAttributes();
    this.handleClickSidebar();
  }

  handleSelectInput = () => {
    $(".input_select2").select2({
      maximumSelectionLength: 10,
    });
  };

  handleSelectInputTag = () => {
    $(".input_select2_tag").select2({
      tags: true,
      maximumSelectionLength: 10,
    });
  };

  handleSelectAttributes = () => {
    $("body").on("click", ".add_fields", () => {
      $(".input_select2_tag").select2({
        tags: true,
        maximumSelectionLength: 10,
      });
    });
  };

  handleClickSidebar = () => {
    $(".navbar-toggler").on("click", () => {
      const body = $("body");
      body.toggleClass("sidebar-icon-only");

      const logo = $("#logo");

      logo.toggleClass("d-none");

      $("li.nav-item.nav-category").find(".pull-right").toggleClass("d-none");
    });

    $(".nav-link").on("click", ({ target }) => {
      $(target)
        .closest(".nav-item.nav-category")
        .find(".panel-collapse")
        .toggleClass("show");
    });
  };
}
