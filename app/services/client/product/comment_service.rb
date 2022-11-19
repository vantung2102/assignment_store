class Client::Product::CommentService < ApplicationService
  def initialize(comment_params, user)
    @comment_params = comment_params
    @user = user
  end

  def call
    product = Product.friendly.find_by(slug: comment_params[:slug])
    comment = product.comments.build(
      user_id: user.id,
      content: comment_params[:content],
      comment_id: comment_params[:comment_id]
    )
    create = comment.save
    message = create ? 'Comment was successfully created.' : 'Comment was failure created.'

    [create, comment, message]
  end

  private

  attr_accessor :comment_params, :user
end
