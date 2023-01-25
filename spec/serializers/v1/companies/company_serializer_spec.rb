# frozen_string_literal: true

require 'rails_helper'

describe V1::Companies::CompanySerializer do
  let(:company) { create :company, :sony }

  subject { described_class.new(company).serializable_hash }

  it do
    data = subject[:data]
    attributes = data[:attributes]

    expect(data[:id]).to eq company.id.to_s
    expect(data[:type]).to eq :company
    expect(attributes[:name]).to eq 'Sony'
    expect(attributes[:name_complete]).to eq 'Sony Company'
  end
end
