class CommentsController < ApplicationController
  before_action :authenticate_user!, only: %i[new create reply_comment]
  before_action :authenticate_user

  def index; end

  def new
    @comment = Comment.new
  end

  def show; end

  def create
    create, comment, message = Client::Product::CommentService.call(comment_params, current_user)

    if create
      html = render_to_string(partial: 'product_detail/shared/list_comment', locals: { comment: comment },
                              layout: false)
      render json: { status: 200, message: message, html: html }
    else
      render json: { status: 500, message: message }
    end
  end

  def reply_comment
    create, comment, message = Client::Product::CommentService.call(comment_params, current_user)

    if create
      html = render_to_string(partial: 'product_detail/shared/child_comment', locals: { child: comment },
                              layout: false)
      render json: { status: 200, html: html }
    else
      render json: { status: 500 }
    end
  end

  private

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:slug, :content, :comment_id)
  end
end
