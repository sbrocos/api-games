# frozen_string_literal: true

require 'rails_helper'

describe Render::ActiveRecord::RecordNotFoundDecorator do
  subject { described_class.new(ActiveRecord::RecordNotFound.new('not found')) }

  it_behaves_like 'error decorator code', 'error.not_found'
  it_behaves_like 'error decorator level', :warning
  it_behaves_like 'error decorator status', :not_found
  it_behaves_like 'error decorator i18n label', 'exception.not_found'
end
