# frozen_string_literal: true

# Contains everything Event-related
class Event < ApplicationRecord
  belongs_to :item
  belongs_to :associated_user, class_name: 'User', foreign_key: 'associated_user_id'
  belongs_to :associated_student, class_name: 'User', foreign_key: 'associated_student_id', optional: true
end
