# frozen_string_literal: true

module V1
  module Admin
    class GamesController < BaseController
      include Serializable

      # POST /v1/admin/games
      def create
        @game = Game.create!(game_params)

        render json: serializer_with_options(game), status: :created
      end

      # PATCH/PUT /v1/admin/games/1
      def update
        game.update!(game_params)

        render json: serializer_with_options(game)
      end

      # DELETE /v1/admin/games/1
      def destroy
        game.unpublished!

        head :no_content
      end

      private

      def define_type
        @company.type
      end

      # Only allow a trusted parameter "white list" through.
      def game_params
        params.require(:game).permit(%i[name url short_plot plot])
      end

      def game
        @game ||= Game.friendly.find(params[:id])
      end

      def options_to_serialize
        { include: %i[developers publishers genres] }
      end
    end
  end
end
