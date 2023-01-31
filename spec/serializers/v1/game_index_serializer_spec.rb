# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ::V1::GameIndexSerializer do
  subject(:serialize) { described_class.new(game, options).serializable_hash }

  let(:options) { { include: %i[developers publishers genres] } }

  include_context :last_of_us_complete

  let(:json_response) do
    {
      data: {
        id: game.id,
        type: :game,
        attributes: attribute_params,
        relationships: relation_params
      },
      included: include_params
    }
  end
  let(:attribute_params) do
    {
      name: 'The Last Of Us',
      url: 'https://thelastofus.org',
      short_plot: 'a story about Joel and Ellie',
    }
  end
  let(:relation_params) do
    {
      developers: {
        data: [{
          id: naughty_dog.id,
          type: :developer
        }]
      },
      publishers: {
        data: [{
          id: sony_publisher.id,
          type: :publisher
        }]
      },
      genres: {
        data: [{
          id: action_genre.id,
          type: :genre
        }, {
          id: survivor_genre.id,
          type: :genre
        }]
      }
    }
  end
  let(:include_params) do
    [
      {
         id: naughty_dog.id,
          type: :developer,
          attributes: {
            name: 'Naughty Dog',
            name_complete: 'Naughty Dog Developer\'s'
          }
      }, {
        id: sony_publisher.id,
        type: :publisher,
        attributes: {
          name: 'Sony',
          name_complete: 'Sony Publisher'
        }
      }, {
        id: action_genre.id,
        type: :genre,
        attributes: { name: 'Action'  }
      }, {
        id: survivor_genre.id,
        type: :genre,
        attributes: { name: 'Survivor' }
      }
    ]
  end

  context 'when it have developer associated' do
    let(:game) { last_of_us }

    it 'returns all data' do
      expect(serialize).to eq json_response
    end
  end

  context 'when it not have developers associated' do
    let(:game) { create(:game) }
    let(:attribute_params) do
      {
        name: 'MyString',
        url: 'MyString',
        short_plot: 'MyString',
      }
    end
    let(:relation_params) { {} }
    let(:include_params) { [] }

    it 'returns hash with relationships and included fields empties' do
      expect(serialize).to eq json_response
    end
  end
end
