# frozen_string_literal: true

require 'rails_helper'

describe Render::StandardErrorDecorator do
  subject { described_class.new({}) }

  it_behaves_like 'error decorator code', 'exception.unknown'
  it_behaves_like 'error decorator level', :error
  it_behaves_like 'error decorator status', :internal_server_error
end
