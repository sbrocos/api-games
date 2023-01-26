# frozen_string_literal: true

module Render
  module ActiveRecord
    class RecordInvalidDecorator < Render::BaseDecorator
      level :warning

      def status
        :unprocessable_entity
      end

      def errors
        invalid_resource_errors(messages)
      end

      private

      def messages
        return exception.errors.messages if exception.class.name != 'ActiveRecord::RecordInvalid'

        exception.record.errors.messages
      end
    end
  end
end
