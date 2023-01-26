# frozen_string_literal: true

require 'rails_helper'

describe Render::ApiGame::Exceptions::ParameterInvalidDecorator do
  subject { described_class.new(ApiGame::Exceptions::ParameterInvalid.new(field)) }

  let(:field) { 'foo' }

  # it_behaves_like 'error decorator code', 'exception.invalid_foo'
  it_behaves_like 'error decorator level', :warning
  # it_behaves_like 'error decorator i18n label', 'error.invalid_parameter'
end
