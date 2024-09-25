# To deliver this notification:
#
# CommentNotifier.with(record: @post, message: "New post").deliver(User.all)

class CommentNotifier < Noticed::Base

  deliver_by :database  # Save notification in the database

  param :comment  # The comment that triggered the notification

  # Message for the notification
  def message
    "#{params[:comment].user.name} commented on your post."
  end

  # URL for the notification
  def url
    post_url(params[:comment].post)  # Link to the post where the comment was made
  end
  # Add your delivery methods
  #
  # deliver_by :email do |config|
  #   config.mailer = "UserMailer"
  #   config.method = "new_post"
  # end
  #
  # bulk_deliver_by :slack do |config|
  #   config.url = -> { Rails.application.credentials.slack_webhook_url }
  # end
  #
  # deliver_by :custom do |config|
  #   config.class = "MyDeliveryMethod"
  # end

  # Add required params
  #
  # required_param :message
end
