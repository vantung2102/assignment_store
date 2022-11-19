class Comment < ApplicationRecord
  belongs_to :parent_comment, class_name: 'Comment', optional: true, foreign_key: :comment_id
  has_many :child_comment, class_name: 'Comment', dependent: :destroy
  belongs_to :product
  belongs_to :user

  validates :content, presence: true, length: { minimum: 6, maximum: 500 }
end
