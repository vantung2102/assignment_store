import "../../lib/jquery.scrollUp.min";

export default class MainController {
  constructor() {
    this.handleLoader();
    this.handleScrollUp();
    this.showIconCart();
  }

  handleLoader = () => {
    $("#loader").fadeOut("slow");
    $(".show_body").css("display", "block");
  };

  handleScrollUp = () => {
    $(() => {
      $.scrollUp({
        scrollName: "scrollUp", // Element ID
        scrollDistance: 300, // Distance from top/bottom before showing element (px)
        scrollFrom: "top", // 'top' or 'bottom'
        scrollSpeed: 300, // Speed back to top (ms)
        easingType: "linear", // Scroll to top easing (see http://easings.net/)
        animation: "fade", // Fade, slide, none
        animationSpeed: 200, // Animation in speed (ms)
        scrollTrigger: false, // Set a custom triggering element. Can be an HTML string or jQuery object
        //scrollTarget: false, // Set a custom target element for scrolling to the top
        scrollText: '<i class="fa fa-angle-up"></i>', // Text for element, can contain HTML
        scrollTitle: false, // Set a custom <a> title if required.
        scrollImg: false, // Set true to use image
        activeOverlay: false, // Set CSS color to display scrollUp active point, e.g '#00FFFF'
        zIndex: 2147483647, // Z-Index for the overlay
      });
    });
  };

  showIconCart = () => {
    $.cookie.json = true;
    // return $.cookie("add_to_cart") ? $.cookie("add_to_cart") : [];
    const carts = $.cookie("add_to_cart") ? $.cookie("add_to_cart") : [];
    $(".count-product").get(0).innerText =
      carts?.length > 0 ? carts.length : "";
  };
}
