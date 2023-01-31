# frozen_string_literal: true

module V1
  module Serializable
    extend ActiveSupport::Concern

    def serializer(resource)
      ::V1.const_get("#{name_serializer(resource)}Serializer").new(resource).serializable_hash.to_json
    end

    def serializer_with_options(resource)
      ::V1.const_get("#{name_serializer(resource)}Serializer").new(resource, **options_to_serialize).
        serializable_hash.to_json
    end

    private

    def name_serializer(resource)
      return resource.first.class.name if resource.is_a?(ActiveRecord::Relation)

      resource.class.name
    end
  end
end
