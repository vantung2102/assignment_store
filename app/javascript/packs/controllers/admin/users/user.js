export default class User {
  constructor() {
    this.handleImageInput();
  }

  handleImageInput = () => {
    $(document).on("change", "#user_avatar", function () {
      const preview = $(".preview");
      const file = $("#user_avatar")[0].files[0];

      const reader = new FileReader();

      $(reader).on("load", function () {
        preview.append(
          $("<img/>", {
            src: this.result,
            class: "img-thumbnail",
          })
        );
      });

      reader.readAsDataURL(file);
    });
  };
}
