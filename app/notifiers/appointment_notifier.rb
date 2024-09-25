# To deliver this notification:
#
# AppointmentNotifier.with(record: @post, message: "New post").deliver(User.all)

class AppointmentNotifier < Noticed::Base

  deliver_by :database
  
  param :appointment

  def message
    "Your appointment with #{params[:appointment].patient.name} has been confirmed for #{params[:appointment].appointment_date.strftime('%A, %B %d, %Y at %I:%M %p')}. Please check your schedule."
  end

  def url
    appointment_url(params[:appointment])
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
