# frozen_string_literal: true

require 'rails_helper'

describe 'Publishers', type: :request do
  let(:publisher) { create :publisher, :sony, developers: [create(:developer, :naughty_dog)] }
  let(:serializer) { V1::PublisherSerializer.new(*serializer_params).serializable_hash.to_json }

  before { publisher }

  describe 'GET /v1/publishers' do
    let(:serializer_params) { [ [publisher] ] }

    before { get v1_publishers_path }

    it_behaves_like :good_response, 'publishers'
  end

  describe 'GET /v1/publishers/:id' do
    context 'with invalid data' do
      before { get v1_publisher_path(1234) }

      it do
        expect(response).to have_http_status 404
      end
    end

    context 'with valid data' do
      let(:serializer_params) do
        [
          publisher, { include: [:developers] }
        ]
      end

      before { get v1_publisher_path(publisher) }

      context 'with developer associated' do
        it_behaves_like :good_response, 'publisher'
      end

      context 'without studio associated' do
        let(:publisher) { create(:publisher) }

        it_behaves_like :good_response, 'publisher'
      end
    end
  end
end
