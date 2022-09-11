import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  images() {
    // $(document).ready(function () {
    //   $(document).on("change", "#product_images", function () {
    //     const $preview = $(".preview");
    //     $(".preview").empty();
    //     const newFiles = $(this).prop("files");
    //     if (newFiles) $.each(newFiles, readAndPreview);
    //     function readAndPreview(i, file) {
    //       if (!/\.(jpe?g|png|gif)$/i.test(file.name)) {
    //         return alert(file.name + " is not an image");
    //       }
    //       const reader = new FileReader();
    //       $(reader).on("load", function () {
    //         $preview.append(
    //           $("<img/>", {
    //             src: this.result,
    //             class: "img-thumbnail",
    //           })
    //         );
    //       });
    //       reader.readAsDataURL(file);
    //     }
    //   });
    // });
  }
}
