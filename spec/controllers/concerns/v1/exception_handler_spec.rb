# frozen_string_literal: true

require 'rails_helper'

describe 'V1::ExceptionHandler', type: :controller do
  shared_examples_for 'module inclusion' do |mod|
    controller(V1::BaseController) do
      include V1::ExceptionHandler
    end

    it "includes #{mod} module" do
      expect(controller.class.included_modules.include?(mod)).to be true
    end
  end

  describe 'rescue_from ActiveRecord::RecordInvalid' do
    class FakeResource
      class << self
        def i18n_scope; end

        def human_attribute_name(_attribute_key_name, _options); end
      end

      def errors
        active_model_errors = ActiveModel::Errors.new(self)
        active_model_errors.add(:field1, 'Error a')
        active_model_errors.add(:field2, 'Error b')
        active_model_errors.add(:field2, 'Error c')
        active_model_errors
      end
    end

    controller(V1::BaseController) do
      include V1::ExceptionHandler

      def index
        exception = ActiveRecord::RecordInvalid.new FakeResource.new
        fail exception
      end
    end

    it_behaves_like 'error response', 422 do
      let(:error_response) do
        { errors: [
          {
            field: 'field1',
            code: 'invalid_resource',
            message: 'Error a'
          },
          {
            field: 'field2',
            code: 'invalid_resource',
            message: 'Error b, Error c'
          }
        ] }.to_json
      end
    end

    it_behaves_like 'module inclusion', V1::ExceptionHandler
  end

  describe 'rescue_from ActionController::ParameterMissing' do
    controller(V1::BaseController) do
      include V1::ExceptionHandler

      def index
        exception = ActionController::ParameterMissing.new('param_name')
        fail exception
      end
    end

    it_behaves_like 'error response', 400 do
      let(:error_response) do
        { errors: [{
          field: 'param_name',
          code: 'exception.missing_param_name',
          message: I18n.t('error.parameter_not_found')
        }] }.to_json
      end
    end

    it_behaves_like 'module inclusion', V1::ExceptionHandler
  end

  describe 'rescue_from StandardError' do
    controller(V1::BaseController) do
      include V1::ExceptionHandler

      def index
        fail StandardError, 'Unknown exception'
      end
    end

    before { expect(Rollbar).to receive(:error).and_return({}) }

    it_behaves_like 'error response', 500 do
      let(:error_response) do
        { errors: [{
          field: 'base',
          code: 'exception.unknown',
          message: I18n.t('exception.unknown')
        }] }.to_json
      end
    end
  end
end
