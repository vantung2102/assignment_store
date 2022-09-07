$(document).on("change", "#user_avatar", function () {
  const preview = $(".preview.img-thumbnail");
  // const preview1 = document.querySelector(".preview.img-thumbnail");
  // console.log(preview[0]);
  // console.log(preview1);

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
