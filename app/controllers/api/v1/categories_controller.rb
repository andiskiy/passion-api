# frozen_string_literal: true

module Api
  module V1
    class CategoriesController < ApplicationController
      def index
        categories = Category.all
        json_response(categories)
      end
    end
  end
end
