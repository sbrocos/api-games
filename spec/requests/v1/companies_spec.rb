# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Companies', type: :request do
  let(:company) { create(:company) }

  describe 'GET /v1/companies' do
    before { company }

    it do
      get v1_companies_path

      expect(response).to have_http_status 200
      expect(response).to match_response_schema('companies', true)
      expect(response.body).to eq V1::CompanySerializer.new([company]).serializable_hash.to_json
    end
  end

  describe 'GET /v1/companies/:id' do
      context 'with invalid data' do
        it do
          get v1_company_path(1234)

          expect(response).to have_http_status 404
        end
      end

      context 'with valid data' do
        before { get v1_company_path(company) }

        context 'when request is valid' do
          it do
            expect(response).to have_http_status 200
            expect(response).to match_response_schema('company', true)
            expect(response.body).to eq V1::CompanySerializer.new(company).serializable_hash.to_json
          end
        end
      end
    end
end
