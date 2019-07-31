# frozen_string_literal: true

module Api
  module V1
    class CourseSerializer < ActiveModel::Serializer
      attributes :id, :name, :author, :state, :created_at, :updated_at
      belongs_to :category
    end
  end
end
