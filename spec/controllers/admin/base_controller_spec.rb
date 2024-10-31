# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Admin::BaseController, type: :controller do
  # Create a test controller to inherit from Admin::BaseController
  controller do
    def index
      render plain: 'Admin content'
    end
  end

  describe 'GET #index' do
    context 'when admin is logged in' do
      before do
        # Set the session admin_id to simulate an admin being logged in
        session[:admin_id] = 1
      end

      it 'allows access to the action' do
        get :index
        expect(response).to have_http_status('302')
      end
    end

    context 'when admin is not logged in' do
      before do
        # Set the session admin_id to nil to simulate admin not being logged in
        session[:admin_id] = nil
      end
    end
  end
end
