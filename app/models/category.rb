# frozen_string_literal: true

# == Schema Information
#
#  Table name: categories
#  id          :integer  not null, primary key
#  name        :string
#  vertical_id :bigint
#  state       :integer  default: 0
#  created_at  :datetime not null
#  updated_at  :datetime not null
#

class Category < ApplicationRecord
  include NameValidateable

  STATES = %w[active disabled].freeze
  enum state: STATES

  # Associations
  belongs_to :vertical

  # Validations
  validates :name, presence: true, uniqueness: true

  name_validateable 'vertical'
end
