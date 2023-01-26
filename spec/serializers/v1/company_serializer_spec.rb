# frozen_string_literal: true

require 'rails_helper'

describe V1::CompanySerializer do
  subject(:serializer) { described_class.new(company).serializable_hash }

  let(:company) { create :company, :sony }

  it do
    data = serializer[:data]
    attributes = data[:attributes]

    expect(data[:id]).to eq company.id.to_s
    expect(data[:type]).to eq :company
    expect(attributes[:name]).to eq 'Sony'
    expect(attributes[:name_complete]).to eq 'Sony Company'
    expect(attributes[:url]).to eq 'https://sony.com'
  end
end
