class ApplicationController < ActionController::API
    include JsonWebToken

    before_action :authenticate_request

    private
    
    def authenticate_request
        header = request.headers["Authorization"]
        header = header.split(" ").last if header

        return render json: { error: 'Authorization header missing' }, status: :unauthorized unless header
        
        decoded = jwt_decode(header)

        if decoded[:user_id]
            @current_user = User.find(decoded[:user_id])
        elsif decoded[:doctor_id]
            @current_user = Doctor.find(decoded[:doctor_id])
        elsif decoded[:patient_id]
            @current_user = Patient.find(decoded[:patient_id])
        else
            render json: { error: 'unauthorized' }, status: :unauthorized
        end
    end
end
