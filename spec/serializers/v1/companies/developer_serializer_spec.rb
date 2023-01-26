# frozen_string_literal: true

require 'rails_helper'

describe V1::Companies::DeveloperSerializer do
  let(:company) { create :developer, :naughty_dog }

  subject { described_class.new(company).serializable_hash }

  it do
    data = subject[:data]
    attributes = data[:attributes]

    expect(data[:id]).to eq company.id.to_s
    expect(data[:type]).to eq :developer
    expect(attributes[:name]).to eq 'Naughty Dog'
    expect(attributes[:name_complete]).to eq 'Naughty Dog Developer\'s'
  end
end
