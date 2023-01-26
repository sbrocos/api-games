# frozen_string_literal: true

module Render
  require 'pry'
  class BaseDecorator < SimpleDelegator
    alias exception __getobj__
    delegate :t, to: :class

    class << self
      attr_accessor :_level, :_field

      def level(value)
        self._level = value
      end

      def t(key, *args)
        key && I18n.t!(key, *args)
      rescue I18n::MissingTranslationData => e
        Rollbar.warning(e, "Untranslated key: #{key} (args)")
        nil
      end
    end

    def level
      self.class._level || :warning
    end

    def field
      exception.try(:param) || self.class._field || :base
    end

    def to_render_params
      { status:, json: { errors:, rollbar: report_error }.compact }
    end

    def error
      {
        field:,
        code:,
        message:
      }.merge(verbose).compact
    end

    private

    def report_error
      return if level == :no_report

      url = rollbar(exception)
      url unless Rails.env.production?
    end

    def errors
      @one_error = true
      [error]
    end

    def status
      exception.try(:status) || :bad_request
    end

    def code
      exception.try(:code)
    end

    def i18n_label
      code
    end

    def i18n_message
      t(i18n_label)
    end

    def message
      i18n_message || t(unknown)
    end

    def unknown
      :'exception.unknown'
    end

    def verbose
      return {} unless verbose_error?
      verbose_exception
    end

    def verbose_exception
      {
        exception: exception.inspect,
        backtrace: clean_backtrace(exception.backtrace)[0..30]
      }
    end

    def verbose_error?
      !Rails.env.production?
    end

    def clean_backtrace(backtrace)
      Array(backtrace).map { |filename| filename.sub("#{Rails.root}/", '') }
    end

    def rollbar(error)
      if @one_error
        rollbar_error_url(Rollbar.public_send(level, description, error, rollbar_info))
      else
        rollbar_error_url(Rollbar.public_send(level, error, rollbar_info))
      end
    end

    def description
      "#{not_translated_tag}#{message}"
    end

    def not_translated_tag
      translated? ? '' : '[not translated] '
    end

    def rollbar_info
      {
        context:,
        code:,
        i18n_label:,
        i18n_message:,
        translated: translated?
      }
    end

    def translated?
      !i18n_message.nil?
    end

    def context
      exception.try(:context) || {}
    end

    def rollbar_error_url(payload)
      return unless payload.is_a? Hash

      Rollbar::Util.uuid_rollbar_url(payload, Rollbar.configuration)
    end

    def invalid_resource_errors(errors, error_namespace = nil)
      errors.keys.map do |error_key|
        {
          field: error_key.to_s,
          code: [error_namespace, 'invalid_resource'].compact.join('.'),
          message: generate_message(errors, error_key)
        }
      end
    end

    def generate_message(errors, error_key)
      I18n.t(errors[error_key].first, default: nil) ||
        "#{I18n.t("fields.#{error_key}", raise: I18n::MissingTranslationData)}: " \
        "#{errors[error_key].join(', ')}"
    rescue I18n::MissingTranslationData
      errors[error_key].join(', ')
    end
  end
end
