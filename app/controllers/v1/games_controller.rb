# frozen_string_literal: true

module V1
  class GamesController < ::V1::BaseController
    include Serializable

    # GET /v1/games/
    def index
      render json: ::V1::GameIndexSerializer.new(Game.all).serializable_hash.to_json()
    end

    # GET /v1/games/:uuid
    def show
      render json: serializer_with_options(games)
    end

    def options_to_serialize
      { include: %i[developers publishers genres] }
    end

    private

    def games
      Game.friendly.find(params[:id])
    end
  end
end
