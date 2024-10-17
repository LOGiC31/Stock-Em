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

  describe 'POST #create' do
    context 'with valid parameters' do
      let(:valid_attributes) do
        {
          item_name: 'Test Item',
          quality_score: 50,
          serial_number: '123456',
          category: 'Electronics',
          currently_available: true
        }
      end

      it 'creates a new item' do
        expect {
          post :create, params: { item: valid_attributes }
        }.to change(Item, :count).by(1)
      end

      it 'redirects to the items index' do
        post :create, params: { item: valid_attributes }
        expect(response).to redirect_to(items_path)
        expect(flash[:notice]).to eq('Item was successfully created.')
      end
    end

    context 'with invalid parameters' do
      let(:invalid_attributes) do
        {
          item_name: '', # Invalid because it's blank
          quality_score: 150, # Invalid because it's out of range
          serial_number: '123456',
          category: 'Invalid Category', # Invalid because it's not included
          currently_available: nil # Invalid because it must be true or false
        }
      end

      it 'does not create a new item' do
        expect {
          post :create, params: { item: invalid_attributes }
        }.not_to change(Item, :count)
      end

      it 'renders the new template' do
        post :create, params: { item: invalid_attributes }
        expect(response).to render_template(:new)
      end

      it 'assigns the unsaved item to @item' do
        post :create, params: { item: invalid_attributes }
        expect(assigns(:item)).to be_a_new(Item)
        expect(assigns(:item)).to be_invalid
      end
    end
  end
end
