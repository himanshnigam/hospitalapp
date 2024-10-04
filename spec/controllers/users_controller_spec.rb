require 'rails_helper'

RSpec.describe UsersController, type: :controller do

    let!(:user) { create(:user) }

    describe 'GET #index' do
        it 'returns a successful response with all users' do
            get :index
            expect(response).to have_http_status(:ok)
            expect(JSON.parse(response.body)).to be_an(Array)
        end
    end

    describe 'GET #show' do
        it 'returns the user details for a valid ID' do
            get :show, params: { id: user.id }

            expect(response).to have_http_status(:ok)
            expect(JSON.parse(response.body)['id']).to eq(user.id)
        end

        it 'returns a 404 for an invalid user ID' do
            get :show, params: { id: 'invalid_id' }

            expect(response).to have_http_status(:not_found)
        end
    end

    describe 'PATCH #update' do
        it 'updates the user with valid attributes' do
            patch :update, params: { id: user.id, user: { name: 'Updated Name' } }

            expect(response).to have_http_status(:ok)
            expect(JSON.parse(response.body)['name']).to eq('Updated Name')
        end

        it 'returns an error for invalid attributes' do
            patch :update, params: { id: user.id, user: { email: '' } }

            expect(response).to have_http_status(:unprocessable_entity)
            expect(JSON.parse(response.body)).to have_key('errors')
        end
  end

    describe 'DELETE #destroy' do
        it 'deletes the user and returns no content' do
            delete :destroy, params: { id: user.id }

            expect(response).to have_http_status(:no_content)
        end

        it 'returns a 404 for an invalid user ID' do
            delete :destroy, params: { id: 'invalid_id' }

            expect(response).to have_http_status(:not_found) 
        end
    end
end
