require 'rails_helper'

RSpec.describe ApplicationCable::Connection, type: :channel do
  it 'inherits from ActionCable::Connection::Base' do
    expect(ApplicationCable::Connection).to be < ActionCable::Connection::Base
  end

  it 'successfully connects with a valid identifier' do
    connect

    expect(connection).to be_a(ApplicationCable::Connection)
  end
end
