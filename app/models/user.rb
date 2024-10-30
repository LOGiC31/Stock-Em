# frozen_string_literal: true

# Contains everything User-related
class User < ApplicationRecord
  before_create :set_default_role

  # Update role based on auth level before saving
  before_save :update_role_based_on_auth_level
  validates :email, presence: true
  validates :uin, numericality: { only_integer: true }, allow_blank: true
  validates :contact_no, numericality: { only_integer: true }, allow_blank: true

  private

  def update_role_based_on_auth_level
    self.role = case auth_level
                when 2
                  'Admins'
                when 1
                  'Assistants'
                when 0
                  'Students'
                else # rubocop:disable Style/EmptyElse
                  nil
                end
  end

  def set_default_role
    self.role = 'Students' if role.blank?
    self.auth_level = 0 if auth_level.blank?
  end
end
