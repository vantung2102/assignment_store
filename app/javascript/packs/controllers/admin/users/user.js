import Raicon from "raicon";

export default class UserController {
  constructor() {
    this.handleImageInput();
  }

  handleImageInput = () => {
    $("body").on("change", "#user_avatar", () => {
      const preview = $(".preview");
      const file = $("#user_avatar")[0].files[0];

      const reader = new FileReader();

      $(reader).on("load", ({ target }) => {
        preview.append(
          $("<img/>", {
            src: target.result,

            class: "img-thumbnail",
          })
        );
      });

      reader.readAsDataURL(file);
    });
  };
}
