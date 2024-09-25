class DoctorAuthenticationController < ApplicationController
    skip_before_action :authenticate_request, only: [:login, :signup]
  
    def login
        @doctor = Doctor.find_by_email(params[:email])
        if @doctor&.authenticate(params[:password])
            token = jwt_encode(doctor_id: @doctor.id)
            render json: { token: token }, status: :ok
        else
            render json: { error: 'unauthorized' }, status: :unauthorized
        end
    end

    def signup
        @doctor = Doctor.new(doctor_params)
        if @doctor.save
            token = jwt_encode(doctor_id: @doctor.id)
            render json: { doctor: @doctor, token: token }, status: :created
        else
            render json: { errors: @doctor.errors.full_messages }, status: :unprocessable_entity
        end
    end

    private

    def doctor_params
        params.permit(:name, :email, :password, :speciality, :bio)
    end
end
