# frozen_string_literal: true

require 'rails_helper'

RSpec.describe DisclaimersController, type: :controller do
  let(:one_disclaimer) { Disclaimer.create!(name: 'One disclaimer', text: 'Test disclaimer', version: '1.0') }
  let(:other_disclaimer) { Disclaimer.create!(name: 'Other disclaimer', text: 'Other disclaimer', version: '2.0') }

  describe 'GET #index' do
    subject { get :index, params: text_param }

    before do
      one_disclaimer
      other_disclaimer
      subject
    end

    context 'when text param is not provided' do
      let(:text_param) { {} }

      it 'returns a successful response' do
        expect(response).to be_successful
      end

      it 'returns a collection of all disclaimers as JSON' do
        expect(response.body).to eq([one_disclaimer, other_disclaimer].to_json)
      end
    end

    context 'when text param is provided' do
      let(:text_param) { { text: 'Test' } }

      it 'returns a successful response' do
        expect(response).to be_successful
      end

      it 'returns a collection of disclaimers matching the text param as JSON' do
        expect(response.body).to eq([one_disclaimer].to_json)
      end
    end
  end

  describe 'GET #show' do
    subject { get :show, params: { id: show_params } }

    before { subject }

    context 'with valid parameters' do
      context 'when id is provided' do
        let(:show_params) { one_disclaimer.id }

        it 'returns a successful response' do
          expect(response).to be_successful
        end

        it 'returns the disclaimer as JSON' do
          expect(response.body).to eq(one_disclaimer.to_json)
        end
      end
    end

    context 'with invalid parameters' do
      context 'when id does not exist' do
        let(:show_params) { 1_234_567_789 }

        it 'returns a bad request status' do
          expect(subject).to have_http_status(:not_found)
        end
      end

      context 'when id is not provided' do
        let(:show_params) { '' }

        it 'returns a bad request status' do
          expect(response).to have_http_status(:bad_request)
        end
      end
    end
  end

  describe 'POST #create' do
    subject { post :create, params: create_params }

    let(:create_params) { { name: 'New disclaimer', text: 'Created disclaimer', version: '3.0'} }

    context 'with valid parameters' do
      it 'creates a new disclaimer' do
        expect { subject }.to change(Disclaimer, :count).by(1)
      end

      it 'returns a created status code' do
        expect(subject).to have_http_status(:created)
      end

      it 'returns the new disclaimer as JSON' do
        expect(subject.body).to eq(Disclaimer.last.to_json)
      end
    end

    context 'with missing parameters' do
      let(:missing_parameter) { create_params.keys.sample }

      before { post :create, params: create_params.except(missing_parameter) }

      it 'returns a bad request status' do
        expect(response).to have_http_status(:bad_request)
      end
    end
  end

  describe 'PUT #update' do
    subject { put :update, params: update_params }

    let(:update_params) { { id: one_disclaimer.id, name: updated_name, version: updated_version } }
    let(:updated_name) { 'Updated Name' }
    let(:updated_version) { '2.0' }

    context 'with valid parameters' do
      before { subject }

      it 'updates the disclaimer\'s name' do
        expect(one_disclaimer.reload.name).to eq(updated_name)
      end

      it 'updates the disclaimer\'s version' do
        expect(one_disclaimer.reload.version).to eq(updated_version)
      end

      it 'returns the updated disclaimer as JSON' do
        expect(JSON.parse(response.body)).to eq(one_disclaimer.reload.as_json)
      end
    end

    context 'with invalid parameters' do
      context 'when id is not provided' do
        before { put :update, params: update_params.merge(id: '') }

        it 'returns a bad request status' do
          expect(response).to have_http_status(:bad_request)
        end
      end

      context 'when id does not exist', focus: true do
        before { put :update, params: update_params.merge(id: 1_234_567_789) }

        it 'returns a bad request status' do
          expect(response).to have_http_status(:not_found)
        end
      end

      context 'when an invalid name attribute is provided' do
        before { put :update, params: update_params.merge(name: nil) }

        it 'returns an unprocessable entity status' do
          expect(response).to have_http_status(:unprocessable_entity)
        end
      end

      context 'when an invalid text attribute is provided' do
        before { put :update, params: update_params.merge(text: nil) }

        it 'returns an unprocessable entity status' do
          expect(response).to have_http_status(:unprocessable_entity)
        end
      end
    end
  end

  describe 'DELETE #destroy' do
    subject { delete :destroy, params: { id: destroy_params } }

    before { one_disclaimer }

    context 'with valid parameters' do
      context 'when id is provided' do
        let(:destroy_params) { one_disclaimer.id }

        it 'destroys the disclaimer' do
          expect { subject }.to change(Disclaimer, :count).by(-1)
        end

        it 'returns a no content status' do
          expect(subject).to have_http_status(:no_content)
        end
      end
    end

    context 'with invalid parameters' do
      context 'when id does not exist' do
        let(:destroy_params) { 1_234_567_789 }

        it 'returns a bad request status' do
          expect(subject).to have_http_status(:not_found)
        end
      end

      context 'when id is not provided' do
        let(:destroy_params) { '' }

        it 'returns a bad request status' do
          expect(subject).to have_http_status(:bad_request)
        end
      end
    end
  end
end
