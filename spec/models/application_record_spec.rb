# frozen_string_literal: true

# spec/models/application_record_spec.rb

require 'rails_helper'

RSpec.describe ApplicationRecord, type: :model do
  it 'inherits from ActiveRecord::Base' do
    expect(ApplicationRecord).to be < ActiveRecord::Base
  end
end
