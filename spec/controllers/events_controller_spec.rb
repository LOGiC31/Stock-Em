RSpec.describe EventsController, type: :controller do
    let(:admin_user) { User.create!(email: 'admin@example.com', auth_level: 2) }
    let(:item) { Item.create!(item_name: 'Item1', serial_number: '12345', category: 'Computer Accessories', quality_score: 10, currently_available: true, image: '', details: 'Item details') }
  
    before do
      # Ensure the controller has an admin user logged in
      allow(controller).to receive(:current_user).and_return(admin_user)
      session[:user_id] = admin_user.id
    end
  
    describe 'POST #publish_event' do
      context 'when event type is Checkout' do
        let(:params) do
          {
            evtype: 'Checkout',
            itemid: item.id,
            teams: 'Team A',
            location: 'Room 101',
            professor: 'Dr. Smith',
            comments: 'No issues',
          }
        end
  
        it 'creates an event and updates the item availability' do
          expect {
            post :publish_event, params: params
          }.to change(Event, :count).by(1)
  
          item.reload
          expect(item.currently_available).to eq(false)
        #   expect(flash[:notice]).to eq("Item successfully checked out.")
        end
      end
  
      context 'when event type is Checkin' do
        let(:params) do
          {
            evtype: 'Checkin',
            itemid: item.id,
            professor: 'Dr. Smith',
            location: 'Room 102',
            comments: 'Returned in good condition',
          }
        end
  
        before do
          item.update!(currently_available: false) # The item is checked out before checkin
        end
  
        it 'creates an event and updates the item availability' do
          expect {
            post :publish_event, params: params
          }.to change(Event, :count).by(1)
  
          item.reload
          expect(item.currently_available).to eq(true)
        #   expect(flash[:notice]).to eq("Item successfully checked in.")
        end
      end
    end
  
    describe 'GET #new' do
      context 'when item is available' do
        it 'sets event type to Checkout' do
          get :new, params: { itemid: item.id }
  
          expect(assigns(:evtype)).to eq('Checkout')
        end
      end
  
      context 'when item is not available' do
        before { item.update!(currently_available: false) }
  
        it 'sets event type to Checkin' do
          get :new, params: { itemid: item.id }
  
          expect(assigns(:evtype)).to eq('Checkin')
        end
      end
    end
  end
  