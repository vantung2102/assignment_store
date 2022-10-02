export default class Main {
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
    $(document).on("click", ".add_fields", function () {
      $(".input_select2_tag").select2({
        tags: true,
        maximumSelectionLength: 10,
      });
    });
  };

  handleClickSidebar = () => {
    $(".navbar-toggler").on("click", function () {
      const body = $("body");
      body.toggleClass("sidebar-icon-only");

      const logo = $("#logo");
      logo.toggleCla("d-none");
    });

    $(".nav-link").on("click", function () {
      $(this)
        .closest(".nav-item.nav-category")
        .find(".panel-collapse")
        .toggleClass("show");
    });
  };
}
