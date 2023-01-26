# frozen_string_literal: true

require 'rails_helper'

describe ::V1::PublisherSerializer do
  subject(:serialize) { described_class.new(company, options).serializable_hash }

  let(:options) { { include: [:developers] } }
  let(:json_response) do
    {
      data: {
        id: company.id.to_s,
        type: :publisher,
        attributes: attributes_params,
        relationships: relationships_params
      },
      included: included_params
    }
  end

  context 'when it have developers associated' do
    include_context :last_of_us_complete

    let(:company) { sony_publisher }
    let(:attributes_params) do
      {
        name: 'Sony',
        name_complete: 'Sony Publisher',
        url: 'https://sony.com',
        city: 'MyString',
        country: 'Japan',
        description: 'the big japanese publisher'
      }
    end
    let(:relationships_params) do
      {
        developers: {
          data: [{
            id: naughty_dog.id,
            type: :developer
          }]
        }
      }
    end
    let(:included_params) do
      [{
        id: naughty_dog.id,
        type: :developer,
        attributes: {
          name: 'Naughty Dog',
          name_complete: 'Naughty Dog Developer\'s'
        }
      }]
    end

    it 'returns all data' do
      expect(serialize).to eq json_response
    end
  end

  context 'when it not have developers associated' do
    let(:company) { create(:publisher) }
    let(:attributes_params) do
      {
        name: 'MyString',
        name_complete: 'MyString',
        url: 'MyString',
        city: 'MyString',
        country: 'MyString',
        description: 'MyString'
      }
    end
    let(:relationships_params) { {} }
    let(:included_params) { [] }

    it 'returns hash with relationships and included fields empties' do
      expect(serialize).to eq json_response
    end
  end
end
