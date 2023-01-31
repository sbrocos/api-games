# frozen_string_literal: true

module V1
  class GameIndexSerializer
    include JSONAPI::Serializer
    set_type :game

    attributes :name, :url, :short_plot

    has_many :developers,
      serializer: ::V1::Companies::DeveloperSerializer,
      if: Proc.new { |record| record.developers.any? }

    has_many :publishers,
      serializer: ::V1::Companies::PublisherSerializer,
      if: Proc.new { |record| record.publishers.any? }

    has_many :genres,
      serializer: ::V1::Games::GenreSerializer,
      if: Proc.new { |record| record.genres.any? }
  end
end
