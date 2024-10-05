require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  describe 'POST #omniauth' do
    let(:auth_hash) do
      {
        'uid' => '12345',
        'provider' => 'facebook',
        'info' => {
          'email' => 'simran@tamu.edu',
          'name' => 'Simran Jot Kaur'
        }
      }
    end

    before do
      request.env['omniauth.auth'] = auth_hash
    end

    context 'when the user is successfully created' do
      it 'creates a new user' do
        expect {
          post :omniauth
        }.to change(User, :count).by(1)
      end

      it 'sets the user_id in the session' do
        post :omniauth
        user = User.find_by(user_id: auth_hash['uid'])
        expect(session[:user_id]).to eq(user.id)
      end

      it 'redirects to the user path with a notice' do
        post :omniauth
        user = User.find_by(user_id: auth_hash['uid'])
        expect(response).to redirect_to(user_path(user))
        expect(flash[:notice]).to eq('You are logged in.')
      end
    end

    context 'when user creation fails' do
      before do
        allow_any_instance_of(User).to receive(:valid?).and_return(false)
      end

      it 'does not create a user' do
        expect {
          post :omniauth
        }.not_to change(User, :count)
      end

      it 'redirects to the welcome path with an alert' do
        post :omniauth
        expect(response).to redirect_to(welcome_path)
        expect(flash[:alert]).to eq('Login failed.')
      end
    end
  end
end
