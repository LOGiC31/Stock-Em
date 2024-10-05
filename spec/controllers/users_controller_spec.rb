require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let(:valid_user) { User.create!(user_id: 1, email: 'vinay@example.com', name: 'Vinay') }

  before do
    allow(controller).to receive(:current_user).and_return(valid_user)
  end
  describe 'GET #show' do
    let(:user) { User.create!(name: 'Vinay', email: 'vinay@example.com') }

    it 'assigns the requested user to @current_user' do
      get :show, params: { id: user.id }
      expect(controller.instance_variable_get(:@current_user)).to eq(user)
    end

    it 'returns a success response' do
      get :show, params: { id: user.id }
      expect(response).to have_http_status(:ok) # 200 status for success
    end
  end
end
