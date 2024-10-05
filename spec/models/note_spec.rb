# frozen_string_literal: true

# spec/models/note_spec.rb

require 'rails_helper'

RSpec.describe Note, type: :model do
  describe 'associations' do
    it { should belong_to(:item) }
    it { should belong_to(:user) }
  end
end
