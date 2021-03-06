# frozen_string_literal: true

module Api
  module V1
    module Verticals
      class CategorySerializer < ActiveModel::Serializer
        attributes :id, :name, :state, :created_at, :updated_at
        belongs_to :vertical
      end
    end
  end
end
