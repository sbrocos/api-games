# frozen_string_literal: true

module V1
  module Companies
    module Typezable
      extend ActiveSupport::Concern

      COMPANY_TYPES = %w[Company Publisher Developer]

      def type
        @type ||= define_type || 'Company'
      end

      private

      def companies
        @companies ||= Object.const_get(type).all
      end

      def company
        @company ||= Company.friendly.find(params[:id])
      end

      def valid_type?(type_name)
        return false unless COMPANY_TYPES.include?(type_name)

        true
      end

      def define_type
        type_name = params[:type] || 'Company'

        return unless valid_type?(type_name)

        type_name
      end
    end
  end
end
