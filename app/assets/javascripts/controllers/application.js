function Like(options) {
  var module = this;
  var defaults = {
    template: {},
    container: {},
    api: {},
    data: {},
  };
  module.settings = $.extend({}, defaults, options);

  module.handleLike = function () {};

  module.init = function () {
    module.handleLike();
  };
}

$(document).ready(function () {
  like = new Like();
  like.init();
});
