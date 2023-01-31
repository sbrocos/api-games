# frozen_string_literal: true

module V1
  module Games
    class GenreSerializer
      include JSONAPI::Serializer

      attributes :name
    end
  end
end
