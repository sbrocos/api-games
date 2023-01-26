# frozen_string_literal: true

require 'rails_helper'

describe Render::ActiveRecord::RecordInvalidDecorator do
  let(:instance) { build(:company, name: nil) }
  let(:errors_array_hash) do
    [
      {
       field: 'name',
       code: 'invalid_resource',
       message: 'can\'t be blank'
     }
    ]
  end

  before { instance.valid? }

  subject { described_class.new(instance) }

  it_behaves_like 'error decorator level', :warning
  it_behaves_like 'error decorator status', :unprocessable_entity

  it 'returns array with errors' do
    expect(subject.errors).to eq errors_array_hash
  end
end
