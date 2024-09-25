class PatientAuthenticationController < ApplicationController
    skip_before_action :authenticate_request, only: [:login, :signup]

    def login
      @patient = Patient.find_by_email(params[:email])
        if @patient&.authenticate(params[:password])
            token = jwt_encode(patient_id: @patient.id)
            render json: { token: token }, status: :ok
        else
            render json: { error: 'unauthorized' }, status: :unauthorized
        end
    end
  
    def signup
      @patient = Patient.new(patient_params)
        if @patient.save

            PatientMailer.successful_signup(@patient).deliver_now
            token = jwt_encode(patient_id: @patient.id)
            render json: { patient: @patient, token: token }, status: :created
        else
            render json: { errors: @patient.errors.full_messages }, status: :unprocessable_entity
        end
    end
  
    private
  
    def patient_params
      params.permit(:name, :email, :password, :age, :address)
    end
end
