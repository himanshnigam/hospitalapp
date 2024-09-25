class AppointmentMailer < ApplicationMailer

    def appointment_confirmation(patient, doctor, appointment)
        @doctor = doctor
        @patient = patient
        @appointment = appointment
        mail(to: @patient.email, subject: "Appointment Confirmation with Dr. #{@doctor.name} from City Hospital." )
    end

end