# frozen_string_literal: true

module Request
  module JsonHelpers
    def json
      JSON.parse(last_response.body)
    end
  end
end
