# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AdminSessionsController, type: :controller do # rubocop:disable Metrics/BlockLength
  let(:admin) { Admin.create(username: 'adminuser', password: 'password123') }

  describe 'GET #dashboard' do
    context 'when logged in as admin' do
      before do
        session[:admin_id] = admin.id
      end

      it 'assigns @users' do
        user1 = User.create(name: 'user1', email: 'user1@example.com')
        user2 = User.create(name: 'user2', email: 'user2@example.com')

        get :dashboard
        expect(assigns(:users)).to match_array([user1, user2])
      end
    end
  end

  describe 'GET #new' do
    it 'renders the new template' do
      get :new
      expect(response).to render_template(:new)
    end
  end

  describe 'POST #create' do
    context 'with valid credentials' do
      it 'sets session[:admin_id] and redirects to dashboard' do
        post :create, params: { username: admin.username, password: 'password123' }

        expect(session[:admin_id]).to eq(admin.id)
        expect(response).to redirect_to(admin_dashboard_path)
        expect(flash[:notice]).to eq('Logged in as admin successfully!')
      end
    end

    context 'with invalid credentials' do
      it 're-renders the new template with alert' do
        post :create, params: { username: admin.username, password: 'wrongpassword' }

        expect(session[:admin_id]).to be_nil
        expect(response).to render_template(:new)
        expect(flash[:alert]).to eq('Invalid username or password')
      end
    end
  end

  describe 'DELETE #destroy' do
    before do
      session[:admin_id] = admin.id
    end

    it 'clears session[:admin_id] and redirects to login page' do
      delete :destroy

      expect(session[:admin_id]).to be_nil
      expect(response).to redirect_to(admin_login_path)
      expect(flash[:notice]).to eq('Logged out of admin')
    end
  end
end
