require 'rails_helper'

RSpec.describe AuthenticationController do

    describe 'hitting POST signup request' do
        context 'create user with correct details are given for signup to' do
            let(:user_attributes) { attributes_for(:user) }

            it 'return valid details as filled' do
                post :signup, params: { user: user_attributes }
        
                expect(response).to have_http_status(:created)
                expect(JSON.parse(response.body)['user']['email']).to eq(user_attributes[:email])
            end
        
            it 'return a JWT token after successful signup' do
                post :signup, params: { user: user_attributes }

                expect(JSON.parse(response.body)).to include('token')
                expect(JSON.parse(response.body)['token']).to_not be_nil
            end
        
            it 'send welcome email after signup and check its various conditions' do
                post :signup, params: { user: user_attributes }

                expect(ActionMailer::Base.deliveries).to_not be_nil
                expect(ActionMailer::Base.deliveries.count).to eq(1)
                expect(ActionMailer::Base.deliveries.first.to[0]).to eq(user_attributes[:email])
            end
        end

        context 'when invalid user detailed are provided' do
            let(:invalid_user_attributes) { { name: '', email: '', password: '' } }
      
            it 'returns error and does not create the user' do
              post :signup, params: { user: invalid_user_attributes }
      
              expect(response).to have_http_status(:unprocessable_entity)
              expect(JSON.parse(response.body)).to have_key('errors')
            end
      
            it 'does not return a JWT token upon signup' do
              post :signup, params: { user: invalid_user_attributes }
      
              expect(JSON.parse(response.body)).to_not have_key('token')
            end

            it 'does not send email to the invalid user details' do
                post :signup, params: { user: invalid_user_attributes }

                expect(ActionMailer::Base.deliveries).to be_empty
                expect(ActionMailer::Base.deliveries.count).to eq(0)
            end
        end
    end



    describe 'hitting POST login request' do
        let(:user) { create(:user) }

        context 'when correct user details are provided' do

            it 'logs in the user and returns a JWT token' do
                post :login, params: { email: user.email, password: 'password123' }

                expect(response).to have_http_status(:ok)
                expect(JSON.parse(response.body)).to have_key('token')
            end
        end

        context 'when invalid user details are provided' do

            it 'returns an unauthorized error for this user' do
                post :login, params: { email: user.email, password: 'wrong_password' }

                expect(response).to have_http_status(:unauthorized)
                expect(JSON.parse(response.body)).to have_key('error')
            end
        end

        context 'when not signed up user tries to login' do
            
            it 'returns an unauthorized error' do
                post :login, params: { email: 'unknown@example.com', password: 'password123' }

                expect(response).to have_http_status(:unauthorized)
                expect(JSON.parse(response.body)).to have_key('error')
            end
        end
    end
end