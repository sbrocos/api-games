# frozen_string_literal: true

require 'rails_helper'

describe V1::Companies::PublisherSerializer do
  let(:company) { create :publisher, :sony }

  subject { described_class.new(company).serializable_hash }

  it do
    data = subject[:data]
    attributes = data[:attributes]

    expect(data[:id]).to eq company.id.to_s
    expect(data[:type]).to eq :publisher
    expect(attributes[:name]).to eq 'Sony'
    expect(attributes[:name_complete]).to eq 'Sony Publisher'
  end
end
