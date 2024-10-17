# frozen_string_literal: true

# spec/controllers/items_controller_spec.rb

require 'rails_helper'

RSpec.describe ItemsController, type: :controller do
  let!(:item) do
    Item.create(item_name: 'Sample Item', serial_number: '12345', category: 'Electronics', quality_score: 10,
                currently_available: true, image: 'sample_image.jpg', details: 'Sample details')
  end

  let!(:user) { User.create!(email: 'test@example.com') }
  let!(:item) do
    Item.create(item_name: 'Sample Item', serial_number: '12345', category: 'Electronics', quality_score: 10,
                currently_available: true, image: 'sample_image.jpg', details: 'Sample details')
  end

  before do
    # Simulate a logged-in user
    allow(controller).to receive(:current_user).and_return(user)
  end

  describe 'GET #index' do
    it 'returns a successful response' do
      get :index
      expect(response).to have_http_status(:success)
    end

    it 'assigns @items' do
      get :index
      expect(assigns(:items)).to eq([item])
    end

    it 'renders the index template' do
      get :index
      expect(response).to render_template(:index)
    end
  end

  describe 'GET #show' do
    context 'when the item exists' do
      it 'returns a successful response' do
        get :show, params: { id: item.id }
        expect(response).to have_http_status(:success)
      end

      it 'assigns @item' do
        get :show, params: { id: item.id }
        expect(assigns(:item)).to eq(item)
      end

      it 'renders the show template' do
        get :show, params: { id: item.id }
        expect(response).to render_template(:show)
      end
    end

    context 'when the item does not exist' do
      it 'raises an ActiveRecord::RecordNotFound error' do
        expect do
          get :show, params: { id: 9999 } # Assuming this ID does not exist
        end.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end

  describe 'PATCH #set_status' do
    context 'with valid params' do
      it 'updates the item status' do
        patch :set_status, params: { id: item.id, item: { status: 'Damaged', comment: 'Item is damaged.' } }

        item.reload # Reload the item to get the updated attributes
        expect(item.status).to eq('Damaged')
        expect(flash[:notice]).to eq('Item status updated successfully.')
        expect(response).to redirect_to(item)
      end
    end

    context 'with invalid params' do
      it 'does not update the item status and re-renders the show template' do
        patch :set_status, params: { id: item.id, item: { status: 'New', comment: 'Invalid status.' } }

        item.reload
        expect(item.status).to eq(nil)
        expect(flash[:alert]).to eq('Error updating status. Status must be nil, Damaged, Lost, or Not Available.')
        expect(response).to render_template(:show)
      end
    end
  end
end
