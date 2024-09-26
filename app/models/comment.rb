class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :user

  validates :description, presence: true

  after_create :send_notification_to_creator

  private

  def send_notification_to_creator
    CommentNotifier.with(comment: self).deliver_later(post.user)
  end
end
