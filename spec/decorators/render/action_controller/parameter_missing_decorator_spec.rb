# frozen_string_literal: true

require 'rails_helper'

describe Render::ActionController::ParameterMissingDecorator do
  subject do
    described_class.new(ActionController::ParameterMissing.new('parameter'))
  end

  it_behaves_like 'error decorator code', 'exception.missing_parameter'
  it_behaves_like 'error decorator level', :warning
  it_behaves_like 'error decorator i18n label', 'error.parameter_not_found'
end
