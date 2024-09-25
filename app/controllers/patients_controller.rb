class PatientsController < ApplicationController
    before_action :authenticate_request
    before_action :set_patient, only: [:show, :update, :destroy]

    def index
        @patients = Patient.all
        render json: @patients, status: :ok
    end

    def show
        @patient = Patient.find(params[:id])
        render json: @patient, status: :ok
    end

    def create
        @patient = Patient.new(patient_params)
        if @patient.save
           
            PatientMailer.successful_signup(@patient).deliver_now
            token = jwt_encode(patient_id: @patient.id)

            render json: { patient: @pateint, token: token }, status: :created
        else
            render json: { errors: @patient.errors.full_messages },
            status: :unprocessable_entity
        end
    end

    def update
        if @patient.update(patient_params)
          render json: @patient, status: :ok
        else
          render json: { errors: @patient.errors.full_messages }, status: :unprocessable_entity
        end
    end
    
    def destroy
        @patient.destroy
        render json: { message: 'Patient deleted successfully' }, status: :ok
    end
    
    private
    
    def set_patient
        @patient = Patient.find(params[:id])
    end

    private

    def patient_params
        params.require(:patient).permit(:name, :email, :password, :age, :address)
    end
end
