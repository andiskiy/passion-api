require 'rails_helper'

RSpec.describe Api::V1::Categories::CoursesController, type: :controller do
  login_user

  let!(:courses)    { create_list(:course, 10, category_id: category.id) }
  let!(:category)   { create(:category) }
  let(:category_id) { category.id }
  let(:course_id)   { courses.first.id }

  describe 'GET index' do
    before { get :index, params: { category_id: category_id } }

    context 'when category exists' do
      include_examples 'get_index'
    end

    context 'when category does not exist' do
      let(:category_id) { 0 }

      include_examples 'not_found', 'category'
    end
  end

  describe 'GET show' do
    before { get :show, params: { category_id: category_id, id: course_id } }

    context 'when category course exists' do
      it 'returns status code :ok' do
        expect(response).to have_http_status(:ok)
      end

      it 'returns the course' do
        expect(json_data['id']).to eq(course_id.to_s)
      end
    end

    context 'when category course does not exist' do
      let(:course_id) { 0 }

      include_examples 'not_found', 'course'
    end

    context 'when course from another category' do
      let(:category_id) { create(:category).id }

      include_examples 'not_found', 'course'
    end
  end

  describe 'POST create' do
    context 'when request attributes are valid' do
      before { post :create, params: { category_id: category_id, name: 'New course' } }

      it 'returns status code :created' do
        expect(response).to have_http_status(:created)
      end
    end

    context 'when an invalid request' do
      context 'and name is null' do
        before { post :create, params: { category_id: category_id } }

        include_examples 'name_cannot_blank'
      end

      context 'and the same name' do
        before { post :create, params: { category_id: category_id, name: courses.first.name } }

        include_examples 'already_be_taken'
      end
    end
  end

  describe 'PUT update' do
    let(:name) { 'Update name' }

    before { put :update, params: { category_id: category_id, id: course_id, name: name } }

    context 'when course exists' do
      it 'returns status code :ok' do
        expect(response).to have_http_status(:ok)
      end

      it 'updates the course' do
        expect(json['name']).to eq(name)
      end
    end

    context 'when the course does not exist' do
      let(:course_id) { 0 }

      include_examples 'not_found', 'course'
    end

    context 'when the name invalid' do
      context 'and name is null' do
        before { put :update, params: { category_id: category_id, id: course_id, name: nil } }

        include_examples 'name_cannot_blank'
      end

      context 'and not unique' do
        let(:name) { courses.last.name }

        include_examples 'already_be_taken'
      end
    end
  end

  describe 'DELETE destroy' do
    before { delete :destroy, params: { category_id: category_id, id: course_id } }

    it 'returns status code :no_content' do
      expect(response).to have_http_status(:no_content)
    end
  end
end
