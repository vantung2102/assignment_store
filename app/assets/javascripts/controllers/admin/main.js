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

document.addEventListener("turbolinks:load", () => {
  handleSelectInput();
  handleSelectInputTag();
  handleSelectAttributes();
});
