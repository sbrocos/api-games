# frozen_string_literal: true

module V1
  class DeveloperSerializer < CompanySerializer
    belongs_to :publisher,
      serializer: ::V1::Companies::PublisherSerializer,
      if: Proc.new { |record| record.publisher.present? }

    has_many :games,
             serializer: ::V1::Companies::GameSerializer,
             if: Proc.new { |record| record.games.any? }
  end
end
