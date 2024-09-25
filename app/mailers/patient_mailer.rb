class PatientMailer < ApplicationMailer

    def successful_signup(patient)
        @patient = patient
        mail(to: @patient.email, subject: "Welcome to Hospital App, #{@patient.name}!")
    end
end