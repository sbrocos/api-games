# frozen_string_literal: true

module Render
  module ActiveRecord
    class RecordNotFoundDecorator < Render::BaseDecorator
      level :warning

      def status
        :not_found
      end

      def code
        'error.not_found'
      end

      def i18n_label
        'exception.not_found'
      end
    end
  end
end
