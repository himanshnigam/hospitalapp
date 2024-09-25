class DoctorsController < ApplicationController
    before_action :authenticate_request
    before_action :set_doctor, only: [:show, :update, :destroy]

    def index
        @doctors = Doctor.all
        render json: @doctors, status: :ok
    end

    def show
        @doctor = Doctor.find(params[:id])
        render json: @doctor, status: :ok
    end

    def create
        @doctor = Doctor.new(doctor_params)
        if @doctor.save

            token = jwt_encode(doctor_id: @doctor.id)

            render json: { doctor: @doctor, token: token }, status: :created
        else
            render json: { errors: @doctor.errors.full_messages },
            status: :unprocessable_entity
        end
    end

    def update
        if @doctor.update(doctor_params)
          render json: @doctor, status: :ok
        else
          render json: { errors: @doctor.errors.full_messages }, status: :unprocessable_entity
        end
    end
    
    def destroy
        @doctor.destroy
        render json: { message: 'Doctor deleted successfully' }, status: :ok
    end
    
    private
    
    def set_doctor
        @doctor = Doctor.find(params[:id])
    end

    def doctor_params
        params.require(:doctor).permit(:name, :email, :speciality, :bio, :availability)
      end
end
