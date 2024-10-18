# frozen_string_literal: true

# spec/controllers/items_controller_spec.rb

require 'rails_helper'

RSpec.describe ItemsController, type: :controller do
  let!(:user) { User.create!(email: 'test@example.com') }

  let!(:item1) do
    Item.create!(
      serial_number: 'SN1',
      item_name: 'Laptop1',
      category: 'Electronics',
      quality_score: 50,
      currently_available: true,
      details: '',
      created_at: Date.parse('2024-10-01'),
      updated_at: Date.parse('2024-10-02')
    )
  end

  let!(:item2) do
    Item.create!(
      serial_number: 'SN2',
      item_name: 'Chair',
      category: 'Furniture',
      quality_score: 75,
      currently_available: true,
      details: 'abc',
      created_at: Date.parse('2024-10-02'),
      updated_at: Date.parse('2024-10-02')
    )
  end

  let!(:item3) do
    Item.create!(
      serial_number: 'SN3',
      item_name: 'Tablet',
      category: 'Electronics',
      quality_score: 0,
      currently_available: false,
      details: 'comfy!',
      created_at: Date.parse('2024-10-02'),
      updated_at: Date.parse('2024-10-03')
    )
  end

  let!(:item4) do
    Item.create!(
      serial_number: 'SN4',
      item_name: 'Laptop2',
      category: 'Electronics',
      quality_score: 55,
      currently_available: false,
      details: '',
      created_at: Date.parse('2024-10-01'),
      updated_at: Date.parse('2024-10-02')
    )
  end

  before do
    # Simulate a logged-in user
    allow(controller).to receive(:current_user).and_return(user)
  end

  describe 'GET #index' do
    context 'when no filters are applied' do
      it 'returns all items' do
        get :index
        expect(assigns(:items)).to include(item1, item2, item3, item4)
        expect(assigns(:items).size).to eq(4)
      end
    end

    context 'when searching by name' do
      it 'returns items that match the search query' do
        get :index, params: { query: 'lapt' }
        expect(assigns(:items)).to include(item1, item4)
        expect(assigns(:items)).not_to include(item2, item3)
        expect(assigns(:items).size).to eq(2)
      end
    end

    context 'when filtering by availability' do
      it 'returns only available items' do
        get :index, params: { available_only: '1' }
        expect(assigns(:items)).to include(item1, item2)
        expect(assigns(:items)).not_to include(item3, item4)
        expect(assigns(:items).size).to eq(2)
      end
    end

    context 'when searching and filtering together' do
      it 'returns available items that match the search query' do
        get :index, params: { query: 'lapt', available_only: '1' }
        expect(assigns(:items)).to include(item1)
        expect(assigns(:items)).not_to include(item2, item3, item4)
        expect(assigns(:items).size).to eq(1)
      end
    end

    it 'returns a successful response' do
      get :index
      expect(response).to have_http_status(:success)
    end

    it 'assigns all items to @items' do
      get :index
      expect(assigns(:items)).to match_array([item1, item2, item3, item4])
    end

    it 'renders the index template' do
      get :index
      expect(response).to render_template(:index)
    end
  end

  describe 'GET #show' do
    context 'when the item exists' do
      it 'returns a successful response' do
        get :show, params: { id: item1.id }
        expect(response).to have_http_status(:success)
      end

      it 'assigns the requested item to @item' do 
        get :show, params: { id: item1.id }
        expect(assigns(:item)).to eq(item1) 
      end

     it 'renders the show template' do
       get :show, params: { id: item1.id }
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
          currently_available: true,
          status: nil
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

  describe 'PATCH #set_status' do
    context 'with valid params' do
      it 'updates the item status' do
        # Pass a valid status
        patch :set_status, params: { id: item1.id, item: { status: 'Damaged', comment: 'Item is damaged.' } }

        item1.reload # Reload the item to get the updated attributes
        expect(item1.status).to eq('Damaged')
        expect(flash[:notice]).to eq('Item status updated successfully.')
        expect(response).to redirect_to(item1)
      end

      it 'clears the item status when status is empty string' do
        # Test when status is passed as an empty string (should be treated as nil)
        patch :set_status, params: { id: item1.id, item: { status: '', comment: 'Cleared status.' } }

        item1.reload
        expect(flash[:notice]).to eq('Item status updated successfully.')
        expect(response).to redirect_to(item1)
      end
    end

    context 'with invalid params' do
      it 'does not update the item status and re-renders the show template' do
        patch :set_status, params: { id: item1.id, item: { status: 'InvalidStatus', comment: 'Invalid status.' } }

        item1.reload
        expect(item1.status).to eq(nil) # The status remains nil (or whatever it was before)
        expect(flash[:alert]).to eq('Error updating status. Status must be nil, Damaged, Lost, or Not Available.')
        expect(response).to render_template(:show)
      end
    end
  end
end
