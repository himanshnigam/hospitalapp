class Notification < ApplicationRecord
    belongs_to :event, class_name: "Noticed::Event"  # Link to the noticed event
    belongs_to :recipient, polymorphic: true          # The user receiving the notification
end
