export default class Comment {
  constructor() {
    this.handleComment();
    this.handleClickReply();
    this.handleReplyComment();
  }

  handleComment = () => {
    $("#btn_send_comment").on("click", function () {
      const newComment = $(".in-comment");
      const slug = newComment.attr("id").split(" ")[1];
      const content = newComment.val();
      // const files = $("#file_images").prop("files");

      if (content.trim().length == 0) {
        Swal.fire({
          position: "center",
          icon: "error",
          title: "Please input content",
          showConfirmButton: false,
          timer: 1500,
        });
      } else {
        const formData = {
          "comment[slug]": slug,
          "comment[content]": content,
          // "comment[images][]": files,
        };

        $.ajax({
          url: "/comments",
          type: "POST",
          beforeSend: function (xhr) {
            xhr.setRequestHeader(
              "X-CSRF-Token",
              $('meta[name="csrf-token"]').attr("content")
            );
          },
          data: formData,
          dataType: "json",
          // processData: false,
          success: function (response) {
            if (response.status == 200) {
              $(".list_comment").prepend(response.html);
              $(newComment).val("");
            }
          },
          error: function (response) {},
        });
      }
    });
  };

  handleClickReply = () => {
    $("body").on("click", ".reply-comment", function () {
      $(this).closest(".item_comment-user").find(".form-reply").toggle();
    });
  };

  handleReplyComment = () => {
    $(document).on("click", ".btn_reply_comment", function () {
      const newComment = $(this)
        .closest("#form_comment")
        .find(".in-reply-comment");
      const slug = newComment.attr("id").split(" ")[1];
      const content = newComment.val();
      const idComment = newComment.attr("id").split(" ")[2];

      if (content.trim().length != 0) {
        const formData = {
          "comment[slug]": slug,
          "comment[content]": content,
          "comment[comment_id]": idComment,
        };

        $.ajax({
          url: `/comments/${idComment}/reply_comment`,
          type: "POST",
          beforeSend: function (xhr) {
            xhr.setRequestHeader(
              "X-CSRF-Token",
              $('meta[name="csrf-token"]').attr("content")
            );
          },
          data: formData,
          dataType: "json",
          success: function (response) {
            if (response.status == 200) {
              $(".list_comment_chidren").prepend(response.html);
              $(newComment).val("");
            }
          },
          error: function (response) {},
        });
      }
    });
  };
}
