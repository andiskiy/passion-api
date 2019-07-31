require 'rails_helper'

RSpec.describe Api::V1::Verticals::CategoriesController, type: :controller do
  let!(:vertical)   { create(:vertical) }
  let!(:categories) { create_list(:category, 10, vertical_id: vertical.id) }
  let(:vertical_id) { vertical.id }
  let(:category_id) { categories.first.id }

  describe 'GET index' do
    before { get :index, params: { vertical_id: vertical_id } }

    context 'when vertical exists' do
      include_examples 'get_index'
    end

    context 'when vertical does not exist' do
      let(:vertical_id) { 0 }

      include_examples 'not_found', 'vertical'
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

      include_examples 'not_found', 'category'
    end

    context 'when category from another vertical' do
      let(:vertical_id) { create(:vertical).id }

      include_examples 'not_found', 'category'
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
      context 'and name is null' do
        before { post :create, params: { vertical_id: vertical_id } }

        include_examples 'name_cannot_blank'
      end

      context 'and the same name' do
        before { post :create, params: { vertical_id: vertical_id, name: categories.first.name } }

        include_examples 'already_be_taken'
      end

      context 'and the name is like a vertical' do
        let(:vertical) { create :vertical }

        before { post :create, params: { vertical_id: vertical_id, name: vertical.name } }

        include_examples 'already_be_taken'
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

      include_examples 'not_found', 'category'
    end

    context 'when the name invalid' do
      context 'and name is null' do
        before { put :update, params: { vertical_id: vertical_id, id: category_id, name: nil } }

        include_examples 'name_cannot_blank'
      end

      context 'and not unique among categories' do
        let(:name) { categories.last.name }

        before { put :update, params: { vertical_id: vertical_id, id: category_id, name: name } }

        include_examples 'already_be_taken'
      end

      context 'and not unique among verticals + categories' do
        before { put :update, params: { vertical_id: vertical_id, id: category_id, name: create(:vertical).name } }

        include_examples 'already_be_taken'
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
