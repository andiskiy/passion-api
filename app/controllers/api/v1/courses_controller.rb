# frozen_string_literal: true

module Api
  module V1
    class CoursesController < ApplicationController
      def index
        courses = Course.all
        json_response(courses)
      end
    end
  end
end
