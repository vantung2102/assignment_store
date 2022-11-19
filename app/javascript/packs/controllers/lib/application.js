const callAjax = ({ url: url, headers: headers, type: type, data: data }) => {
  return $.ajax({
    url: url,
    headers: headers,
    type: type,
    beforeSend: (xhr) => {
      xhr.setRequestHeader(
        "X-CSRF-Token",
        $('meta[name="csrf-token"]').attr("content")
      );
    },
    data: data,
    dataType: "json",
  });
};

const Ajax = (url, type, data, headers) => {
  return $.ajax({
    url: url,
    headers: headers,
    type: type,
    beforeSend: (xhr) => {
      xhr.setRequestHeader(
        "X-CSRF-Token",
        $('meta[name="csrf-token"]').attr("content")
      );
    },
    data: data,
    dataType: "json",
  });
};

const loadPage = ({ time: time }) => {
  $("#loader").css("display", "flex");
  setTimeout(() => {
    $("#loader").css("display", "none");
  }, time);
};

const changeUrl = (url) => {
  window.history.pushState({}, "", url);
};

const getUrlParameter = (sParam) => {
  let sPageURL = window.location.search.substring(1),
    sURLVariables = sPageURL.split("&"),
    sParameterName,
    i;

  for (i = 0; i < sURLVariables.length; i++) {
    sParameterName = sURLVariables[i].split("=");

    if (sParameterName[0] === sParam) {
      return sParameterName[1] === undefined
        ? true
        : decodeURIComponent(sParameterName[1]);
    }
  }
  return false;
};

const popupFire = (position, icon, title, time) => {
  Swal.fire({
    position: position,
    icon: icon,
    title: title,
    showConfirmButton: false,
    timer: time,
  });
};

const popupConform = (title) => {
  return Swal.fire({
    title: title,
    showDenyButton: true,
    confirmButtonText: "Yes",
    denyButtonText: `No`,
  });
};

const redirect = (url, time) => {
  if (time == undefined) Turbolinks.visit(url);
  else {
    setTimeout(() => {
      Turbolinks.visit(url);
    }, time);
  }
};

const getLocale = () => {
  const locale = getUrlParameter("locale");
  return locale == false || locale == "en" ? "en" : "vi";
};

const actionController = (action, controller, callback) => {
  document.addEventListener(`raicon:after:${controller}#${action}`, () => {
    callback;
  });
};

export {
  callAjax,
  Ajax,
  loadPage,
  changeUrl,
  getUrlParameter,
  popupFire,
  popupConform,
  redirect,
  getLocale,
  actionController,
};
