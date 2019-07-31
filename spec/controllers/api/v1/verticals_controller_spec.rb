require 'rails_helper'

RSpec.describe Api::V1::VerticalsController, type: :controller do
  let!(:verticals)  { create_list(:vertical, 10) }
  let(:vertical_id) { verticals.first.id }

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
      let(:vertical_id) { 100 }

      it 'returns status code :not_found' do
        expect(response).to have_http_status(:not_found)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Vertical with 'id'=100/)
      end
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
      before { post :create, params: { name: nil } }

      it 'returns status code :unprocessable_entity' do
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'returns a validation failure message' do
        expect(response.body).to match(/Validation failed: Name can't be blank/)
      end
    end
  end

  describe 'PUT update' do
    context 'when the name valid' do
      before { put :update, params: { id: vertical_id, name: name } }

      let(:name) { 'Shopping' }

      it 'updates the record' do
        expect(json['name']).to eq(name)
      end

      it 'returns status code :ok' do
        expect(response).to have_http_status(:ok)
      end
    end

    context 'when the name invalid' do
      before { put :update, params: { id: vertical_id, name: name } }

      let(:name) { verticals.last.name }

      it 'returns a validation failure message' do
        expect(response.body).to match(/Validation failed: Name has already been taken/)
      end

      it 'returns status code :unprocessable_entity' do
        expect(response).to have_http_status(:unprocessable_entity)
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
