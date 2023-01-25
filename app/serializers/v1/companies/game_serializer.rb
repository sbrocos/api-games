# frozen_string_literal: true

module V1
  module Companies
    class GameSerializer
      include FastJsonapi::ObjectSerializer

      attributes :name
    end
  end
end
