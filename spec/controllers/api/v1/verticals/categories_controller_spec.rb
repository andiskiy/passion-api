require 'rails_helper'

RSpec.describe Api::V1::Verticals::CategoriesController, type: :controller do
  let!(:vertical)   { create(:vertical) }
  let!(:categories) { create_list(:category, 20, vertical_id: vertical.id) }
  let(:vertical_id) { vertical.id }
  let(:category_id) { categories.first.id }

  describe 'GET index' do
    before { get :index, params: { vertical_id: vertical_id } }

    context 'when vertical exists' do
      it 'returns status code :ok' do
        expect(response).to have_http_status(:ok)
      end

      it 'returns all vertical categories' do
        expect(json_data.size).to eq(20)
      end
    end

    context 'when vertical does not exist' do
      let(:vertical_id) { 0 }

      it 'returns status code :not_found' do
        expect(response).to have_http_status(:not_found)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find vertical/i)
      end
    end
  end

  describe 'GET show' do
    before { get :show, params: { vertical_id: vertical_id, id: category_id } }

    context 'when vertical category exists' do
      it 'returns status code :ok' do
        expect(response).to have_http_status(:ok)
      end

      it 'returns the category' do
        expect(json_data['id']).to eq(category_id.to_s)
      end
    end

    context 'when vertical category does not exist' do
      let(:category_id) { 0 }

      it 'returns status code :not_found' do
        expect(response).to have_http_status(:not_found)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find category/i)
      end
    end

    context 'when category from another vertical' do
      let(:vertical_id) { create(:vertical).id }

      it 'returns status code :not_found' do
        expect(response).to have_http_status(:not_found)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find category/i)
      end
    end
  end

  describe 'POST create' do
    context 'when request attributes are valid' do
      before { post :create, params: { vertical_id: vertical_id, name: 'New Category' } }

      it 'returns status code :created' do
        expect(response).to have_http_status(:created)
      end
    end

    context 'when an invalid request' do
      before { post :create, params: { vertical_id: vertical_id } }

      it 'returns status code :unprocessable_entity' do
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'returns a failure message' do
        expect(response.body).to match(/Validation failed: Name can't be blank/i)
      end
    end
  end

  describe 'PUT update' do
    let(:name) { 'Update name' }

    before { put :update, params: { vertical_id: vertical_id, id: category_id, name: name } }

    context 'when category exists' do
      it 'returns status code :ok' do
        expect(response).to have_http_status(:ok)
      end

      it 'updates the category' do
        expect(json['name']).to eq(name)
      end
    end

    context 'when the category does not exist' do
      let(:category_id) { 0 }

      it 'returns status code :not_found' do
        expect(response).to have_http_status(:not_found)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find category/i)
      end
    end
  end

  describe 'DELETE destroy' do
    before { delete :destroy, params: { vertical_id: vertical_id, id: category_id } }

    it 'returns status code :no_content' do
      expect(response).to have_http_status(:no_content)
    end
  end
end
