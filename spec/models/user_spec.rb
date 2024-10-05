# spec/models/user_spec.rb

require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    subject { User.new(email: email) } 

    context 'when email is present' do
      let(:email) { 'simran@tamu.edu' }

      it 'is valid' do
        expect(subject).to be_valid
      end
    end

    context 'when email is not present' do
      let(:email) { nil }

      it 'is not valid' do
        expect(subject).not_to be_valid
      end

    end
  end
end
