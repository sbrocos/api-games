# frozen_string_literal: true

module V1
  module Companies
    module Serializable
      extend ActiveSupport::Concern

      private

      def options_to_serialize
        case type
        when 'Developer'
          { include: %i[publisher games] }
        when 'Publisher'
          { include: [:developers] }
        else
          {}
        end
      end
    end
  end
end
