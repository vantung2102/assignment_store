import Raicon from "raicon";

export default class CommentController {
  constructor() {
    this.handleComment();
    this.handleClickReply();
    this.handleReplyComment();
  }

  handleComment = () => {
    $("body").on("click", "#btn_send_comment", () => {
      const newComment = $(".in-comment");
      const slug = newComment.attr("id").split(" ")[1];
      const content = newComment.val();

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
        };

        $.ajax({
          url: "/comments",
          type: "POST",
          beforeSend: (xhr) => {
            xhr.setRequestHeader(
              "X-CSRF-Token",
              $('meta[name="csrf-token"]').attr("content")
            );
          },
          data: formData,
          dataType: "json",
          success: (response) => {
            if (response.status == 200) {
              $(".list_comment").prepend(response.html);
              $(newComment).val("");
            }
          },
          error: (response) => {},
        });
      }
    });
  };

  handleClickReply = () => {
    $("body").on("click", ".reply-comment", ({ target }) => {
      $(target).closest(".item_comment-user").find(".form-reply").toggle();
    });
  };

  handleReplyComment = () => {
    $("body").on("click", ".btn_reply_comment", ({ target }) => {
      const newComment = $(target)
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
          beforeSend: (xhr) => {
            xhr.setRequestHeader(
              "X-CSRF-Token",
              $('meta[name="csrf-token"]').attr("content")
            );
          },
          data: formData,
          dataType: "json",
          success: (response) => {
            if (response.status == 200) {
              $(".list_comment_chidren").prepend(response.html);
              $(newComment).val("");
            }
          },
          error: (response) => {},
        });
      }
    });
  };
}
