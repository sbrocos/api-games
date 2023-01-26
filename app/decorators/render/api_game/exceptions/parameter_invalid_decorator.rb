# frozen_string_literal: true

module Render
  module ApiGame
    module Exceptions
      class ParameterInvalidDecorator < Render::BaseDecorator
        level :warning

        def code
          "exception.invalid_#{field}"
        end

        def i18n_label
          'error.invalid_parameter'
        end
      end
    end
  end
end
