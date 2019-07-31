# frozen_string_literal: true

module Api
  module V1
    module Categories
      class CoursesController < ApplicationController
        before_action :set_category
        before_action :set_course, only: %i[show update destroy]

        def index
          json_response(@category.courses)
        end

        def show
          json_response(@course)
        end

        def create
          course = @category.courses.create!(course_params)
          json_response(course, :created)
        end

        def update
          @course.update!(course_params)
          json_response(@course, :ok)
        end

        def destroy
          @course.destroy
          head :no_content
        end

        private

        def set_category
          @category = Category.find(params[:category_id])
        end

        def set_course
          @course = @category.courses.find(params[:id])
        end

        def course_params
          params.permit(:name, :author, :state)
        end
      end
    end
  end
end
