# frozen_string_literal: true

require 'rails_helper'

describe ::V1::DeveloperSerializer do
  let(:options) { { include: [:publisher, :games] } }

  subject { described_class.new(company, options).serializable_hash }

  context 'when it have company associated' do
    include_context :last_of_us_complete

    let(:company) { naughty_dog }

    it do
      attributes = subject[:data][:attributes]
      relationships = subject[:data][:relationships]
      included = subject[:included]

      expect(subject[:data][:id]).to eq naughty_dog.id.to_s
      expect(subject[:data][:type]).to eq :developer
      expect(attributes[:name]).to eq 'Naughty Dog'
      expect(attributes[:name_complete]).to eq 'Naughty Dog Developer\'s'
      expect(attributes[:url]).to eq 'https://naughty-dogs.com'
      expect(attributes[:description]).to eq 'important games developer'
      expect(relationships[:publisher][:data][:id]).to eq sony_publisher.id.to_s
      expect(relationships[:games][:data].first[:id]).to eq last_of_us.id.to_s
      expect(included[0][:id]).to eq sony_publisher.id.to_s
      expect(included[0][:type]).to eq :publisher
      expect(included[0][:attributes][:name]).to eq 'Sony'
      expect(included[0][:attributes][:name_complete]).to eq 'Sony Publisher'
      expect(included[1][:id]).to eq last_of_us.id.to_s
      expect(included[1][:type]).to eq :game
      expect(included[1][:attributes][:name]).to eq 'The Last Of Us'
    end
  end

  context 'when it not have company associated' do
    let(:company) { create(:developer) }

    it do
      expect(subject[:data][:relationships]).to eq({})
      expect(subject[:included]).to eq []
    end
  end
end
