require 'rails_helper'

RSpec.describe Api::V1::CategoriesController, type: :controller do
  before { create_list(:category, 10) }

  describe 'GET index' do
    before { get :index }

    it 'verticals size is 10' do
      expect(json_data.size).to eq(10)
    end

    it 'verticals not to be emty' do
      expect(json_data).not_to be_empty
    end

    it 'returns status code :ok' do
      expect(response).to have_http_status(:ok)
    end
  end
end
