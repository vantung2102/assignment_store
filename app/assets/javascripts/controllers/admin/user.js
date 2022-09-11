function User() {
  var module = this;

  module.handleImageInput = function () {
    $(document).on("change", "#user_avatar", function () {
      const preview = $(".preview.img-thumbnail");

      const file = $("#user_avatar")[0].files[0];

      const reader = new FileReader();

      reader.onloadend = function () {
        preview[0].src = reader.result;
      };

      if (file) {
        preview.css("display", "block");
        reader.readAsDataURL(file);
      } else {
        preview[0].src = "";
      }
    });
  };

  module.init = function () {
    module.handleImageInput();
  };
}

$(document).ready(function () {
  user = new User();
  user.init();
});
