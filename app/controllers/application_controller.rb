# frozen_string_literal: true

class ApplicationController < ActionController::API
  before_action :authenticate_user!
  respond_to :json

  include Response
  include ExceptionHandler
end
