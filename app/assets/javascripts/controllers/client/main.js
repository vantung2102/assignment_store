const handleLoader = () => {
  $("#loader").fadeOut("slow");
  $(".show_body").css("display", "block");
};

const handleScrollUp = () => {
  $(function () {
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

const handleSliderSlick = () => {
  $(".pro-dec-big-img-slider").slick({
    slidesToShow: 1,
    slidesToScroll: 1,
    arrows: false,
    draggable: false,
    fade: false,
    asNavFor: ".product-dec-slider-small",
  });

  $(".product-dec-slider-small").slick({
    slidesToShow: 3,
    slidesToScroll: 1,
    asNavFor: ".pro-dec-big-img-slider",
    dots: false,
    focusOnSelect: true,
    fade: false,
    prevArrow:
      '<a class="left item-control"><i class="fa fa-angle-left"></i></a>',
    nextArrow:
      '<a class="right item-control"><i class="fa fa-angle-right"></i></a>',
  });

  $(".item-control:not(.slick-arrow)")
    .closest(".slick-slide:not(.slick-cloned)")
    .remove();
};

document.addEventListener("turbolinks:load", () => {
  handleLoader();
  handleScrollUp();
  handleSliderSlick();
});
