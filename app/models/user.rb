# frozen_string_literal: true

# Contains everything User-related
class User < ApplicationRecord
  validates :email, presence: true
  validates :uin, numericality: { only_integer: true }, allow_blank: true
  validates :contact_no, numericality: { only_integer: true }, allow_blank: true
end
