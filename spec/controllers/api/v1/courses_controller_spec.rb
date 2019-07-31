require 'rails_helper'

RSpec.describe Api::V1::CoursesController, type: :controller do
  login_user

  before { create_list(:course, 10) }

  describe 'GET index' do
    before { get :index }

    include_examples 'get_index'
  end
end
