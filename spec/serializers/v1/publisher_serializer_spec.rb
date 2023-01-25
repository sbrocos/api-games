# frozen_string_literal: true

require 'rails_helper'

describe ::V1::PublisherSerializer do
  let(:options) { { include: [:developers] } }

  subject(:serialize) { described_class.new(company, options).serializable_hash }

  context 'when it have developers associated' do
    include_context :last_of_us_complete

    let(:company) { sony_publisher }

    it do
      attributes = serialize[:data][:attributes]
      relationships = serialize[:data][:relationships][:developers][:data]
      included = serialize[:included]

      expect(serialize[:data][:id]).to eq company.id.to_s
      expect(serialize[:data][:type]).to eq :publisher
      expect(attributes[:name]).to eq 'Sony'

      expect(attributes[:name_complete]).to eq 'Sony Publisher'
      expect(attributes[:url]).to eq 'https://sony.com'
      expect(attributes[:description]).to eq 'the big japanese publisher'

      expect(included[0][:type]).to eq :developer
      expect(included[0][:id]).to eq relationships[0][:id]
      expect(included[0][:attributes][:name]).to eq 'Naughty Dog'
      expect(included[0][:attributes][:name_complete]).to eq 'Naughty Dog Developer\'s'
    end
  end

  context 'when it not have developers associated' do
    let(:company) { create(:publisher) }

    it do
      expect(serialize[:data][:relationships]).to eq({})
      expect(serialize[:included]).to eq []
    end
  end
end
