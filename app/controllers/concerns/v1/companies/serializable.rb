# frozen_string_literal: true

module V1
  module Companies
    module Serializable
      extend ActiveSupport::Concern

      def serializer(resource)
        ::V1.const_get("#{type}Serializer").new(resource).serializable_hash.to_json
      end

      def serializer_with_options(resource)
        ::V1.const_get("#{type}Serializer").new(resource, options).serializable_hash.to_json
      end

      private

      def options
        case type
        when 'Developer'
          { include: [:publisher, :games] }
        when 'Publisher'
          { include: [:developer] }
        else
          {}
        end
      end
    end
  end
end
