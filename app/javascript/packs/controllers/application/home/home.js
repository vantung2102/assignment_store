import Raicon from "raicon";
import "../../lib/jquery.cookie";

import {
  Ajax,
  loadPage,
  changeUrl,
  getUrlParameter,
  getLocale,
} from "../../lib/application";

export default class HomeController {
  locale = getLocale();

  api = {
    search: (keyword) => {
      return `/search/${keyword}`;
    },
    changeCategory: (slug) => {
      return `/category/${slug}`;
    },
    changeBrand: (slug) => {
      return `/brand/${slug}`;
    },
    loadMore: `/product/load_more`,
  };

  constructor() {
    this.handleSearch();
  }

  changeCategory = () => {
    $("body").on("click", ".category", ({ target }) => {
      const slug = $(target).attr("id").split("_")[0];
      const category = $(target);

      Ajax(this.api.changeCategory(slug), "GET", { slug: slug })
        .done((res) => {
          if (res.status == 200) {
            $(".category").removeClass("active");
            category.addClass("active");

            $(".features_items").replaceWith(res.html);
            $(".btn-load_more").remove();

            changeUrl(`?category=${slug}`);
          } else {
            console.log(res);
          }
        })
        .fail((res) => {
          console.log(res);
        });
    });
  };

  loadCategory = () => {
    const panel = $(".panel.panel-default").find(".category.active");
    if (panel) {
      panel.closest(".panel-collapse").addClass("in");
    }
  };

  changeBrand = () => {
    $("body").on("click", ".brand__item", ({ target }) => {
      const brand = $(target);
      const slug = $(target).attr("id").split("_")[0];

      Ajax(this.api.changeBrand(slug), "GET", { slug: slug })
        .done((res) => {
          if (res.status == 200) {
            $(".brand__item").removeClass("active");
            brand.addClass("active");

            $(".features_items").replaceWith(res.html);
            $(".btn-load_more").remove();

            changeUrl({ url: `?brand=${slug}` });
          }
        })
        .fail((res) => {});
    });
  };

  loadMore = () => {
    $("body").on("click", ".btn-load_more", () => {
      const page =
        getUrlParameter("page") === false ? 1 : getUrlParameter("page");

      Ajax(this.api.loadMore, "GET", { page: page })
        .done((res) => {
          if (res.status == 200) {
            if (res.page != "error_page") {
              $(".features_items").append(res.html);
              const next_page = parseInt(page) + 1;
              const url = "?page=" + next_page;
              changeUrl(url);

              if (res.page == "last_page") {
                $(".load_more").hide();
              } else {
                $(".load_more").show();
              }
            } else if (res.page == "error_page") {
              changeUrl("/?page=1");
            }

            loadPage({ time: 200 });
          }
        })
        .fail((res) => {});
    });
  };

  handleSearch = () => {
    $("body").on("keypress", ".input_search", (e) => {
      if (e.keyCode == 13) {
        const keyword = $(e.target).val();

        Ajax(
          this.api.search(keyword),
          "GET",

          { search: keyword }
        )
          .done((res) => {
            console.log(res);
            loadPage({ time: 200 });
            $(".features_items").replaceWith(res.html);
            $(".btn-load_more").remove();
            $("html, body").animate(
              {
                scrollTop: $(".features_items").offset().top,
              },
              1000
            );
            changeUrl(`/?search=${keyword}`);
          })
          .fail((res) => {});
      }
    });
  };

  index = () => {
    document.addEventListener("raicon:after:home#index", () => {
      this.changeCategory();
      this.loadCategory();
      this.changeBrand();
      this.loadMore();
    });
  };
}

Raicon.register("home", HomeController);
