# frozen_string_literal: true

require 'rails_helper'

RSpec.describe WelcomeController, type: :controller do
  describe 'GET #index' do
    context 'when the user is not logged in' do
      before do
        # Simulate a logged-out state
        allow(controller).to receive(:logged_in?).and_return(false)
      end

      it 'does not redirect' do
        get :index
        expect(response).not_to be_redirect
      end
    end
  end
end
