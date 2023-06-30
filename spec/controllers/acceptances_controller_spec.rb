# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AcceptancesController, type: :controller do
  let(:one_user) { User.create!(name: 'Paul', email: 'paul@gmail.com') }
  let(:one_disclaimer) { Disclaimer.create!(name: 'One disclaimer', text: 'Test disclaimer', version: '1.0') }

  describe 'GET #index' do
    subject { get :index, params: index_params }

    let(:other_user) { User.create!(name: 'Layla', email: 'layla@gmail.com') }
    let(:other_disclaimer) { Disclaimer.create!(name: 'Other disclaimer', text: 'Test disclaimer', version: '2.0') }
    let(:one_acceptance) { Acceptance.create!(disclaimer_id: one_disclaimer.id, user_id: one_user.id) }
    let(:other_acceptance) { Acceptance.create!(disclaimer_id: other_disclaimer.id, user_id: one_user.id) }
    let(:another_acceptance) { Acceptance.create!(disclaimer_id: other_disclaimer.id, user_id: other_user.id) }

    before do
      one_acceptance
      other_acceptance
      another_acceptance
    end

    context 'when user_id is provided' do
      let(:index_params) { { user_id: one_user.id } }

      before { subject }

      it 'returns ok status code' do
        expect(response).to have_http_status(:ok)
      end

      it 'renders a collection of acceptances for the given user as JSON' do
        expect(response.body).to eq([one_acceptance, other_acceptance].to_json)
      end

      it 'returns the correct number of acceptances' do
        expect(JSON.parse(response.body).count).to eq(2)
      end
    end

    context 'when user_id is not provided' do
      let(:index_params) { {} }

      before { subject }

      it 'returns ok status code' do
        expect(response).to have_http_status(:ok)
      end

      it 'renders all acceptances as JSON' do
        expect(response.body).to eq([one_acceptance, other_acceptance, another_acceptance].to_json)
      end

      it 'returns the correct number of acceptances' do
        expect(JSON.parse(response.body).count).to eq(3)
      end
    end
  end

  describe 'POST #create' do
    subject { post :create, params: create_params }

    let(:create_params) { { disclaimer_id: one_disclaimer, user_id: one_user } }

    context 'with valid parameters' do
      it 'creates a new acceptance' do
        expect { subject }.to change(Acceptance, :count).by(1)
      end

      it 'returns created status code' do
        expect(subject).to have_http_status(:created)
      end

      it 'returns the new acceptance' do
        expect(subject.body).to eq(Acceptance.last.to_json)
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
end
