require 'rails_helper'

RSpec.describe Api::V1::VerticalsController, type: :controller do
  login_user

  let!(:verticals)  { create_list(:vertical, 10) }
  let(:vertical_id) { verticals.first.id }

  describe 'GET index' do
    before { get :index }

    include_examples 'get_index'
  end

  describe 'GET show' do
    before { get :show, params: { id: vertical_id } }

    context 'when the record exists' do
      it 'vertical not to be emty' do
        expect(json_data).not_to be_empty
      end

      it 'id match from vertical' do
        expect(json_data['id']).to eq(vertical_id.to_s)
      end

      it 'returns status code :ok' do
        expect(response).to have_http_status(:ok)
      end
    end

    context 'when the record does not exist' do
      let(:vertical_id) { 0 }

      include_examples 'not_found', 'vertical'
    end
  end

  describe 'POST create' do
    let(:name) { 'Vertical test' }

    context 'when the request is valid' do
      before { post :create, params: { name: name } }

      it 'creates a vertical' do
        expect(json['name']).to eq(name)
      end

      it 'returns status code :created' do
        expect(response).to have_http_status(:created)
      end
    end

    context 'when the request is invalid' do
      context 'and name is null' do
        before { post :create, params: { name: nil } }

        include_examples 'name_cannot_blank'
      end

      context 'and the same name' do
        before { post :create, params: { name: verticals.first.name } }

        include_examples 'already_be_taken'
      end

      context 'and the name is like a category' do
        let(:category) { create :category }

        before { post :create, params: { name: category.name } }

        include_examples 'already_be_taken'
      end
    end
  end

  describe 'PUT update' do
    context 'when the name valid' do
      let(:name) { 'Shopping' }

      before { put :update, params: { id: vertical_id, name: name } }

      it 'updates the record' do
        expect(json['name']).to eq(name)
      end

      it 'returns status code :ok' do
        expect(response).to have_http_status(:ok)
      end
    end

    context 'when the name invalid' do
      context 'and name is null' do
        before { put :update, params: { id: vertical_id, name: nil } }

        include_examples 'name_cannot_blank'
      end

      context 'and not unique among verticals' do
        let(:name) { verticals.last.name }

        before { put :update, params: { id: vertical_id, name: name } }

        include_examples 'already_be_taken'
      end

      context 'and not unique among verticals + categories' do
        before { put :update, params: { id: vertical_id, name: create(:category).name } }

        include_examples 'already_be_taken'
      end
    end
  end

  describe 'DELETE destroy' do
    before { delete :destroy, params: { id: vertical_id } }

    it 'returns status code :no_content' do
      expect(response).to have_http_status(:no_content)
    end
  end
end
