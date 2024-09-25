class AppointmentsController < ApplicationController
    before_action :authenticate_request  

    def create
        doctor = Doctor.find(appointment_params[:doctor_id])

        if doctor.available?
            @appointment = Appointment.new(appointment_params)
            if @appointment.save
            
                AppointmentNotifier.with(appointment: @appointment).deliver_later(@appointment.doctor)
                AppointmentMailer.appointment_confirmation(@appointment.patient, @appointment.doctor, @appointment).deliver_now
                
            render json: { message: 'Appointment created successfully.' }, status: :created
            else
            render json: { errors: @appointment.errors.full_messages }, status: :unprocessable_entity
            end
        else
            render json: { message: 'Doctor is unavailable on the schedule you are trying to book'}, status: :unprocessable_entity
        end
    end
    
    private
    
    def appointment_params
        params.require(:appointment).permit(:doctor_id, :patient_id, :appointment_date, :status)
    end
end
