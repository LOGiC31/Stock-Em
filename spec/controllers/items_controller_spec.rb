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
      category: 'Furnitures',
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
        expect do
          post :create, params: { item: valid_attributes }
        end.to change(Item, :count).by(1)
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
        expect do
          post :create, params: { item: invalid_attributes }
        end.not_to change(Item, :count)
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

  describe 'PUT #update' do
    context 'with valid parameters' do
      let(:new_attributes) do
        {
          item_name: 'Updated Laptop',
          status: 'Not Available',
          quality_score: 60
        }
      end

      it 'updates the item' do
        put :update, params: { id: item1.id, item: new_attributes }
        item1.reload
        expect(item1.item_name).to eq('Updated Laptop')
        expect(item1.currently_available).to eq(false)
      end

      it 'redirects to the item' do
        put :update, params: { id: item1.id, item: new_attributes }
        expect(response).to redirect_to(item1)
        expect(flash[:notice]).to eq('Item was successfully updated.')
      end
    end

    context 'with invalid parameters' do
      let(:invalid_attributes) do
        { item_name: '', quality_score: -10 }
      end

      it 'does not update the item' do
        put :update, params: { id: item1.id, item: invalid_attributes }
        item1.reload
        expect(item1.item_name).not_to eq('')
        expect(item1.quality_score).not_to eq(-10)
      end

      it 'redirects to the item with an alert flash message' do
        put :update, params: { id: item1.id, item: invalid_attributes }
        expect(response).to redirect_to(item1)
        expect(flash[:alert]).to eq('There was a problem updating the item.')
      end
    end
  end
  describe 'DELETE #destroy' do
    it 'deletes the item' do
      expect do
        delete :destroy, params: { id: item1.id }
      end.to change(Item, :count).by(-1)
    end

    it 'redirects to the items index' do
      delete :destroy, params: { id: item1.id }
      expect(response).to redirect_to(items_path)
      expect(flash[:notice]).to eq('Item was successfully deleted.')
    end

    it 'sets an alert flash if deletion fails' do
      allow_any_instance_of(Item).to receive(:destroy).and_return(false)
      delete :destroy, params: { id: item1.id }
      expect(flash[:alert]).to eq('Failed to delete the item.')
      expect(response).to redirect_to(items_path)
    end
  end
end

  describe 'POST #add_note' do

  before do
    # Simulating a user login by setting the session
    session[:user_id] = user.id

    # Mocking the User.find_by method to return the user we created
    allow(User).to receive(:find_by).with(id: session[:user_id]).and_return(user)
  end

    context 'when the note is successfully created' do
      let(:note_message) { 'This is a test note.' }

      before do
        post :add_note, params: { id: item1.id, note_msg: note_message }
      end

      it 'creates a new note for the item' do
        expect(Note.last.msg).to eq(note_message)
        expect(Note.last.item).to eq(item1)
        expect(Note.last.user).to eq(user)
      end

      it 'redirects to the item show page' do
        expect(response).to redirect_to(item_path(item1))
      end

      it 'responds with no content for JSON format' do
        post :add_note, params: { id: item1.id, note_msg: note_message }, format: :json
        expect(response).to have_http_status(:no_content)
      end
    end

    context 'when the note creation fails' do
      before do
        post :add_note, params: { id: item1.id, note_msg: nil }
      end

      it 'does not create a note and redirects back with an error' do
        expect(response).to redirect_to(item_path(item1))
      end
    end
  end
end
