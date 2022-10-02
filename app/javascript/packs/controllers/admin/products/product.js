export default class Product {
  constructor() {
    this.handleImageProductInput();
  }

  handleImageProductInput = () => {
    $("body").on("change", "#product_images", ({ target }) => {
      const $preview = $(".preview");
      $(".preview").empty();

      const newFiles = $(target).prop("files");

      if (newFiles) $.each(newFiles, readAndPreview);

      function readAndPreview(index, file) {
        if (!/\.(jpe?g|png|gif)$/i.test(file.name)) {
          Swal.fire({
            position: "top-center",
            icon: "error",
            title: "File is not an image",
            showConfirmButton: false,
            timer: 2000,
          });
          return;
        }

        const reader = new FileReader();

        $(reader).on("load", ({ target }) => {
          $preview.append(
            $("<img/>", {
              src: target.result,
              class: "img-thumbnail",
            })
          );
        });

        reader.readAsDataURL(file);
      }
    });
  };
}
