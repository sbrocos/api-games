# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Admin Companies', type: :request do
  let(:name_blank) { { 'field' => 'name', 'code' => 'invalid_resource', 'message' => "can't be blank" } }
  let(:name_complete_blank) { { 'field' => 'name_complete', 'code' => 'invalid_resource', 'message' => "can't be blank" } }

  describe '#create' do
    shared_examples_for :create_wrong do
      context 'when is not OK' do
        let(:params) { super().except(*%i[name name_complete url]) }
        let(:error_message) do
          {
            errors: [
              { field: 'name', code: 'invalid_resource', message: 'can\'t be blank' },
              { field: 'name_complete', code: 'invalid_resource', message: 'can\'t be blank' }
            ]
          }
        end

        it 'doesn\'t created any element' do
          expect { request! }.to change(Company, :count).by(0)
        end

        it 'returns a json with errorr messages' do
          expect(response).to have_http_status 422
          expect(response.body).to eq error_message.to_json
        end
      end
    end

    let(:params) { instance.as_json.with_indifferent_access.merge!(type: instance.class.name) }
    let(:request!) { post '/v1/admin/companies', params: { company: params } }

    before { request! }

    context 'when type is Company' do
      let(:instance) { build(:company) }

      context 'when all is OK' do
        it do
          expect(response).to have_http_status 201
          expect(response).to match_response_schema('company')

          expect(response.body).to eq V1::CompanySerializer.new(
            Company.first, {}
          ).serializable_hash.to_json
        end
      end

      it_behaves_like :create_wrong
    end

    context 'when type is Publisher' do
      let(:instance) { build(:publisher) }

      it do
        expect(response).to have_http_status 201
        expect(response).to match_response_schema('publisher')

        expect(response.body).to eq ::V1::PublisherSerializer.new(
          Publisher.first, include: [:developers]
        ).serializable_hash.to_json
      end

      it_behaves_like :create_wrong
    end

    context 'when type is Developer' do
      let(:instance) { build(:developer) }

      it do
        expect(response).to have_http_status 201
        expect(response).to match_response_schema('developer')

        expect(response.body).to eq V1::DeveloperSerializer.new(
          Developer.first, include: [:publisher]
        ).serializable_hash.to_json
      end

      it_behaves_like :create_wrong
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
