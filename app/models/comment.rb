class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :user

  after_create :send_notification_to_creator

  private

  def send_notification_to_creator
    # Send notification to the post creator (post.user)
    CommentNotifier.with(comment: self).deliver_later(post.user)
  end
end
