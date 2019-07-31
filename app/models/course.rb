# frozen_string_literal: true

# == Schema Information
#
#  Table name: courses
#  id          :integer  not null, primary key
#  name        :string
#  author      :string
#  category_id :bigint
#  state       :integer  default: 0
#  created_at  :datetime not null
#  updated_at  :datetime not null
#

class Course < ApplicationRecord
  include AwsResources

  STATES = %w[active disabled].freeze
  enum state: STATES

  # Associations
  belongs_to :category

  # Validations
  validates :name, presence: true, uniqueness: true

  # Callbacks
  # after_create :send_to_sqs

  private

  def send_to_sqs
    queue.send_message(self)
  end
end
