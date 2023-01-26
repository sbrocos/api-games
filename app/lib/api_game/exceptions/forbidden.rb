# frozen_string_literal: true

module ApiGame
  module Exceptions
    class Forbidden < StandardError
      attr_reader :reason

      def initialize(reason = nil)
        @reason = reason
      end

      def code
        "exception.forbidden#{"_#{reason}" if reason}"
      end
    end
  end
end
