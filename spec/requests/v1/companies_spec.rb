# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Companies', type: :request do
  let(:company) { create(:company) }
  let(:serializer) { V1::CompanySerializer.new(*serializer_params).serializable_hash.to_json }

  before { company }

  describe 'GET /v1/companies' do
    let(:serializer_params) { [ [company] ] }

    before { get v1_companies_path }

    it_behaves_like :good_response, 'companies'
  end

  describe 'GET /v1/companies/:id' do
    context 'with invalid data' do
      before { get v1_company_path(1234) }

      it 'returns error json message' do
        expect(response).to have_http_status 404
      end
    end

    context 'with valid data' do
      let(:serializer_params) { [ company ] }

      before { get v1_company_path(company) }

      it_behaves_like :good_response, 'company'
    end
  end
end
