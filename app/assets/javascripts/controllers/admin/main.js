function Main(options) {
  var module = this;

  module.handleSelectInput = function () {
    $(".input_select2").select2({
      maximumSelectionLength: 10,
    });
  };

  module.init = function () {
    module.handleSelectInput();
  };
}

$(document).ready(function () {
  main = new Main();
  main.init();
});
