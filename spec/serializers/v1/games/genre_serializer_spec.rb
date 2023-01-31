# frozen_string_literal: true

require 'rails_helper'

describe V1::Games::GenreSerializer do
  subject(:serialize) { described_class.new(genre).serializable_hash }

  let(:genre) { create :genre, name: 'Action' }
  let(:json_reponse) do
    {
      data: {
        id: genre.id,
        type: :genre,
        attributes: {
          name: 'Action'
        }
      }
    }
  end

  it 'returns hash with dataa about genre' do
    expect(serialize).to eq json_reponse
  end
end
