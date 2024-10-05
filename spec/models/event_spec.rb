# spec/models/event_spec.rb

require 'rails_helper'

RSpec.describe Event, type: :model do
  describe 'associations' do
    it { should belong_to(:item) }
    it { should belong_to(:associated_user).class_name('User') }
    it { should belong_to(:associated_student).class_name('User').optional }
  end
end
