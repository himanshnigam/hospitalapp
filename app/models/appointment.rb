class Appointment < ApplicationRecord
  belongs_to :doctor
  belongs_to :patient

  enum status: { pending: 0, booked: 1, cancelled: 2 }

  validates :appointment_date, presence: true

  after_create :notify_appointment_to_doctor

  private

  def notify_appointment_to_doctor
    AppointmentNotifier.with(appointment: self).deliver_later(doctor)
  end
end
