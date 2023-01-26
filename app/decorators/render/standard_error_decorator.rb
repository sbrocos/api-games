# frozen_string_literal: true

module Render
  class StandardErrorDecorator < Render::BaseDecorator
    level :error

    def code
      'exception.unknown'
    end

    def status
      :internal_server_error
    end
  end
end
