# frozen_string_literal: true

module Api
  module V1
    class VerticalsController < ApplicationController
      before_action :set_vertical, only: %i[show update destroy]

      def index
        vertical = Vertical.all
        json_response(vertical)
      end

      def show
        json_response(@vertical)
      end

      def create
        @vertical = Vertical.create!(vertical_params)
        json_response(@vertical, :created)
      end

      def update
        @vertical.update!(vertical_params)
        json_response(@vertical, :ok)
      end

      def destroy
        @vertical.destroy
        head :no_content
      end

      private

      def set_vertical
        @vertical = Vertical.find(params[:id])
      end

      def vertical_params
        params.permit(:name)
      end
    end
  end
end
