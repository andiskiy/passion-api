# frozen_string_literal: true

module Api
  module V1
    module Verticals
      class CategoriesController < ApplicationController
        before_action :set_vertical
        before_action :set_category, only: %i[show update destroy]

        def index
          json_response(@vertical.categories)
        end

        def show
          json_response(@category)
        end

        def create
          category = @vertical.categories.create!(category_params)
          json_response(category, :created)
        end

        def update
          @category.update(category_params)
          json_response(@category, :ok)
        end

        def destroy
          @category.destroy
          head :no_content
        end

        private

        def set_vertical
          @vertical = Vertical.find(params[:vertical_id])
        end

        def set_category
          @category = @vertical.categories.find(params[:id])
        end

        def category_params
          params.permit(:name, :state)
        end
      end
    end
  end
end
