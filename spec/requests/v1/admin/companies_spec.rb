# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Admin Companies', type: :request do
  let(:name_blank) { { 'field' => 'name', 'code' => 'invalid_resource', 'message' => "can't be blank" } }
  let(:name_complete_blank) { { 'field' => 'name_complete', 'code' => 'invalid_resource', 'message' => "can't be blank" } }

  describe '#create' do
    let(:params) do
      instance.as_json.with_indifferent_access.merge!(
        type: instance.class.name
      )
    end
    let(:request!) { post '/v1/admin/companies', params: { company: params } }

    before { request! }

    context 'when type is Company' do
      let(:instance) { build(:company) }

      it do
        expect(response).to have_http_status 201
        expect(response).to match_response_schema('company')

        expect(response.json).to eq V1::CompanySerializer.new(
          Company.first, {}
        ).serializable_hash.as_json
      end
    end
  end

  describe '#update' do
    let(:instance) { create(:company) }
    let(:request!) do
      patch "/v1/admin/companies/#{instance.id}", params: { company: params }
    end

    context 'when type is company' do
      let(:params) do
        {
          name: 'Updated Name',
          name_complete: 'Updated Name INC.',
          url: 'http:://www.updated.com',
          description: 'Description of Company Updated!!',
          city: 'Barcelona',
          country: 'Spain'
        }
      end

      it_behaves_like 'updating the parameter', :name
      it_behaves_like 'updating the parameter', :name_complete
      it_behaves_like 'updating the parameter', :url
      it_behaves_like 'updating the parameter', :description
      it_behaves_like 'updating the parameter', :city
      it_behaves_like 'updating the parameter', :country

      before { request! }

      it { expect(response).to have_http_status 200 }
    end

    context 'when invalid params' do
      let(:params) { { name: nil, name_complete: nil, description: nil } }

      before { request! }

      it do
        expect(response).to have_http_status 422
        expect(response.json['errors']).to match_array([name_blank, name_complete_blank])
      end
    end
  end
end
