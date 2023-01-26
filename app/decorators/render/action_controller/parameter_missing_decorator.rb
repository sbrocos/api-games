# frozen_string_literal: true

module Render
  module ActionController
    class ParameterMissingDecorator < Render::BaseDecorator
      def code
        "exception.missing_#{field}"
      end

      def i18n_label
        'error.parameter_not_found'
      end
    end
  end
end
