require 'rails_helper'

RSpec.describe UserProfilesController, type: :controller do
  let(:valid_user) { User.create!(user_id: 1, email: 'vinay@example.com', name: 'Vinay Singh') }

  before do
    allow(controller).to receive(:current_user).and_return(valid_user)
  end
  let(:valid_attributes) do
    {
      user_id: 1,
      name: 'Vinay Singh',
      uin: '2345234',
      email: 'vinay@example.com',
      contact_no: '1234567890',
      role: 'student',
      details: 'details',
      auth_level: 1
    }
  end

  let(:invalid_attributes) do
    {
      name: nil,
      email: nil
    }
  end

  let(:user_profile) { User.create!(valid_attributes) }

  describe 'GET #show' do
    it 'returns a success response' do
      get :show, params: { id: user_profile.to_param }
      expect(response).to be_successful
    end
  end

  describe 'GET #new' do
    it 'returns a success response' do
      get :new
      expect(response).to be_successful
    end
  end

  describe 'GET #edit' do
    it 'returns a success response' do
      get :edit, params: { id: user_profile.to_param }
      expect(response).to be_successful
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new UserProfile' do
        expect do
          post :create, params: { user_profile: valid_attributes }
        end.to change(User, :count).by(1)
      end

      it 'redirects to the created user profile' do
        post :create, params: { user_profile: valid_attributes }
        expect(response).to redirect_to(User.last)
      end
    end

    context 'with invalid params' do
      it 'returns a success response (renders new template)' do
        post :create, params: { user_profile: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'PUT #update' do
    context 'with valid params' do
      let(:new_attributes) do
        {
          name: 'new user',
          email: 'newUser@example.com'
        }
      end

      it 'updates the requested user profile' do
        put :update, params: { id: user_profile.to_param, user_profile: new_attributes }
        user_profile.reload
        expect(user_profile.name).to eq('new user')
        expect(user_profile.email).to eq('newUser@example.com')
      end

      it 'redirects to the user profile' do
        put :update, params: { id: user_profile.to_param, user_profile: valid_attributes }
        expect(response).to redirect_to(user_profile)
      end
    end

    context 'with invalid params' do
      it 'renders the edit template' do
        put :update, params: { id: user_profile.to_param, user_profile: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested user profile' do
      user_profile = User.create! valid_attributes
      expect do
        delete :destroy, params: { id: user_profile.to_param }
      end.to change(User, :count).by(-1)
    end

    it 'redirects to the user profiles list' do
      delete :destroy, params: { id: user_profile.to_param }
      expect(response).to redirect_to(user_profiles_url)
    end
  end
end
