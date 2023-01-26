# frozen_string_literal: true

require 'rails_helper'

describe 'Developers', type: :request do
  include_context :last_of_us_complete
  let(:developer) { naughty_dog }
  let(:serializer) { V1::DeveloperSerializer.new(*serializer_params).serializable_hash.to_json }

  before { developer }

  describe 'GET /v1/developers' do
    let(:serializer_params) { [ [developer] ] }

    before { get v1_developers_path }

    it_behaves_like :good_response, 'developers'
  end

  describe 'GET /v1/developers/:id' do
    let(:serializer_params) do
      [
        developer,
        { include: [:publisher, :games] }
      ]
    end

    before { get v1_developer_path(developer) }

    context 'with publisher associated' do
      it_behaves_like :good_response, 'developer'
    end

    context 'without publisher associated' do
      let(:developer) { create(:developer) }

      it_behaves_like :good_response, 'developer'
    end
  end
end
