# frozen_string_literal: true

require 'rails_helper'

describe ::V1::DeveloperSerializer do
  subject(:serialize) { described_class.new(company, options).serializable_hash }

  let(:options) { { include: [:publisher, :games] } }
  let(:json_response) do
    {
      data: {
        id: company.id.to_s,
        type: :developer,
        attributes: attributes_params,
        relationships: relationships_params
      },
      included: included_params
    }
  end


  context 'when it have company associated' do
    include_context :last_of_us_complete

    let(:company) { naughty_dog }
    let(:attributes_params) do
      {
        name: 'Naughty Dog',
        name_complete: 'Naughty Dog Developer\'s',
        url: 'https://naughty-dogs.com',
        city: 'Santa Monica',
        country: 'United States of America',
        description: 'important games developer'
      }
    end
    let(:relationships_params) do
      {
        publisher: {
          data: {
            id: sony_publisher.id,
            type: :publisher
          }
        },
        games: {
          data: [{
            id: last_of_us.id,
            type: :game
          }]
        }
      }
    end
    let(:included_params) do
      [{
         id: sony_publisher.id,
         type: :publisher,
         attributes: {
           name: 'Sony',
           name_complete: 'Sony Publisher'
         }
       },
       {
         id: last_of_us.id,
         type: :game,
         attributes: {
           name: 'The Last Of Us',
         }
       }]
    end

    it 'returns all data' do
      expect(serialize).to eq json_response
    end
  end

  context 'when it not have company associated' do
    let(:company) { create(:developer) }
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
