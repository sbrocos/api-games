# frozen_string_literal: true

module V1
  module Companies
    class PublisherSerializer
      include FastJsonapi::ObjectSerializer

      attributes :name, :name_complete
    end
  end
end
