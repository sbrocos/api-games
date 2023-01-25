# frozen_string_literal: true

module ApiGame
  module Errors
    class UnprocessableEntity < StandardError; end
    class MatchNotFound < StandardError; end
  end
end
