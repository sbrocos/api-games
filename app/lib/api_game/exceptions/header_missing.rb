# frozen_string_literal: true

module ApiGame
  module Exceptions
    class HeaderMissing < ActionController::ParameterMissing
      def to_s
        "header is missing: #{param}"
      end
    end
  end
end
