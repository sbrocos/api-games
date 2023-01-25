# frozen_string_literal: true

module ApiGame
  module Exceptions
    class ParameterInvalid < Rack::Utils::InvalidParameterError
      attr_reader :param, :extra

      def initialize(param, extra = nil)
        @param = param
        @extra = extra
      end

      def to_s
        ["param is invalid: #{param}", extra].compact.join(', ')
      end
    end
  end
end
