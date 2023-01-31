# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Games', type: :request do
  include_context :last_of_us_complete

  describe 'GET /v1/games' do
    let(:serializer) { V1::GameIndexSerializer.new([last_of_us]).serializable_hash.to_json }

    before { get v1_games_path }

    it_behaves_like :good_response, 'games'
  end

  describe 'GET /v1/games/:id' do
    context 'with invalid data' do
      before { get v1_game_path(1234) }

      it 'returns error json message' do
        expect(response).to have_http_status 404
      end
    end

    context 'with valid data' do
      let(:serializer) do
        V1::GameSerializer.new(last_of_us, include: %i[developers publishers genres]).
          serializable_hash.to_json
      end

      before { get v1_game_path(last_of_us) }

      it_behaves_like :good_response, 'game'
    end
  end
end
