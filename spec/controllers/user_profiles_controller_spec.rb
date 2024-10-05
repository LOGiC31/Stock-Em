# frozen_string_literal: true

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
end
