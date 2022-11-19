import { data } from "jquery";
import { Ajax, changeUrl, actionController } from "../../lib/application";
import Raicon from "raicon";

export default class UserController {
  api = {
    profile: "/user/profile",
    password: "/user/password",
    order: "/user/order/show_order",
    orderDetail: "/user/order/detail",
    address: "/user/addresses/show",
  };

  getUrlParameter = () => {
    const page = window.location.pathname.split("/")[2];
    return page;
  };

  activeMenu = () => {
    const page = this.getUrlParameter();

    if (page == "order") {
      $(".menu_profile--order").addClass("active");
    } else if (page == "profile") {
      $(".menu_profile--profile").addClass("active");
    } else if (page == "addresses") {
      $(".menu_profile--address").addClass("active");
    } else if (page == "password" || page == undefined) {
      $(".menu_profile--password").addClass("active");
    }
  };

  clickMenu = () => {
    $("body").on("click", ".menu_profile li", ({ target }) => {
      $(".menu_profile li").removeClass("active");
      $(target).closest("li").addClass("active");
    });
  };

  clickProfile = () => {
    $("body").on("click", ".menu_profile--profile", () => {
      Ajax(this.api.profile, "POST")
        .done((res) => {
          if (res.status == 200) {
            $(".user_col_right").replaceWith(res.html);
            changeUrl("/user/profile/edit");
          }
        })
        .fail((res) => {});
    });
  };

  clickPassword = () => {
    $("body").on("click", ".menu_profile--password", () => {
      Ajax(this.api.password, "POST")
        .done((res) => {
          if (res.status == 200) {
            $(".user_col_right").replaceWith(res.html);
            changeUrl("/user/password/change");
          }
        })
        .fail((res) => {});
    });
  };

  orderDetail = () => {
    $("body").on("click", ".item_order-body", ({ target }) => {
      const code = $(target).closest(".item_order-body").attr("id");

      Ajax(this.api.orderDetail, "POST", { code: code })
        .done((res) => {
          if (res.status == 200) {
            $(".user_col_right").replaceWith(res.html);
            changeUrl(`/user/order/detail/${code}`);
          }
        })
        .fail((res) => {});
    });
  };

  clickAddress = () => {
    $("body").on("click", ".menu_profile--address", () => {
      Ajax(this.api.address, "POST")
        .done((res) => {
          if (res.status == 200) {
            $(".user_col_right").replaceWith(res.html);
            changeUrl(`/user/addresses`);
          }
        })
        .fail((res) => {});
    });
  };

  action = () => {
    this.orderDetail();
    this.activeMenu();
    this.clickMenu();
    this.clickProfile();
    this.clickPassword();
    this.clickAddress();
  };

  actionUser = (action) => {
    actionController(action, "users", this.action());
  };

  actionAddress = (action) => {
    actionController(action, "addresses", this.action());
  };

  edit = () => {
    this.actionUser("edit");
  };

  password = () => {
    this.actionUser("password");
  };

  update = () => {
    this.actionUser("update");
  };

  index = () => {
    this.actionAddress("index");
  };

  new = () => {
    this.actionAddress("new");
  };

  create = () => {
    this.actionAddress("create");
  };

  edit = () => {
    this.actionAddress("edit");
  };

  update = () => {
    this.actionAddress("update");
  };

  destroy = () => {
    this.actionAddress("destroy");
  };

  index = () => {
    this.actionAddress("index");
  };

  update = () => {
    actionController("update", "devise/registrations", this.action());
  };

  show = () => {
    actionController("update", "orders", this.action());
  };

  showOrderDetail = () => {
    actionController("update", "showOrderDetail", this.action());
  };
}

Raicon.register("users", UserController);
Raicon.register("addresses", UserController);
Raicon.register("devise/registrations", UserController);
Raicon.register("orders", UserController);
