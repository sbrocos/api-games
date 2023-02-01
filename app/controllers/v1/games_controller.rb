# frozen_string_literal: true

module V1
  class GamesController < ::V1::BaseController
    include Serializable

    # GET /v1/games/
    def index
      render json: ::V1::GameIndexSerializer.new(games).serializable_hash.to_json
    end

    # GET /v1/games/:uuid
    def show
      render json: serializer_with_options(game)
    end

    def options_to_serialize
      { include: %i[developers publishers genres] }
    end

    private

    def games
      Game.with_published_state
    end
    def game
      Game.friendly.find(params[:id])
    end
  end
end
