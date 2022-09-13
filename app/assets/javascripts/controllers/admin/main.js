const handleSelectInput = () => {
  $(".input_select2").select2({
    maximumSelectionLength: 10,
  });
};

document.addEventListener("turbolinks:load", () => {
  handleSelectInput();
});
