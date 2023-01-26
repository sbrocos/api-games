# frozen_string_literal: true

require 'rails_helper'

describe V1::Companies::GameSerializer do
  subject { described_class.new(game).serializable_hash }

  let(:game) { create :game, :last_of_us }

  it do
    data = subject[:data]
    attributes = data[:attributes]

    expect(data[:id]).to eq game.id.to_s
    expect(data[:type]).to eq :game
    expect(attributes[:name]).to eq 'The Last Of Us'
  end
end
