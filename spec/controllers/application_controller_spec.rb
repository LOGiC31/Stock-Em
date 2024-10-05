# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ApplicationController, type: :controller do
  controller do
    before_action :require_login

    def index
      render plain: 'This is a test action.'
    end
  end

  let(:user) { User.create!(name: 'Vinay', email: 'vinay@example.com') }

  describe 'before_action :require_login' do
    context 'when user is logged in' do
      before do
        session[:user_id] = user.id
        get :index
      end

      it 'sets the @current_user' do
        expect(controller.instance_variable_get(:@current_user)).to eq(user)
      end

      it 'allows access to the action' do
        expect(response).to have_http_status(:ok)
      end
    end

    context 'when user is not logged in' do
      before do
        get :index
      end

      it 'redirects to the welcome path' do
        expect(response).to redirect_to(welcome_path)
      end

      it 'sets an alert message' do
        expect(flash[:alert]).to eq('You must be logged in to access this section.')
      end
    end
  end

  describe '#logged_in?' do
    context 'when user is logged in' do
      before do
        session[:user_id] = user.id
      end

      it 'returns the current user' do
        expect(controller.send(:logged_in?)).to eq(user)
      end
    end

    context 'when no user is logged in' do
      it 'returns nil' do
        expect(controller.send(:logged_in?)).to be_nil
      end
    end
  end
end
