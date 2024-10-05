# spec/models/item_spec.rb

require 'rails_helper'

RSpec.describe Item, type: :model do
  describe 'validations' do
  end

  describe 'associations' do
  end

  it 'can be instantiated' do
    item = Item.new
    expect(item).to be_an_instance_of(Item)
  end
end
