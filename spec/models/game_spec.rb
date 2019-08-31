# frozen_string_literal: true

require 'rails_helper'

describe Game, type: :model do
  context 'database columns' do
    it do
      is_expected.to have_db_column :name
      is_expected.to have_db_column :slug
      is_expected.to have_db_column :url
      is_expected.to have_db_column :slug
      is_expected.to have_db_column :status
      is_expected.to have_db_column :plot
      is_expected.to have_db_column :short_plot
    end
  end

  context 'associations' do
    it do
      is_expected.to have_many(:companiables)
      is_expected.to have_many(:companies).through(:companiables)
      is_expected.to have_and_belong_to_many(:genres)
    end
  end

  context 'validates' do
    it do
      is_expected.to validate_presence_of :name
      is_expected.to validate_uniqueness_of :name
    end
  end

  describe '.published' do
    context 'when exist a published game' do
      let!(:game_1) { create :game }
      let!(:game_2) { create :game, name: 'Game 2', status: :pending }

      it 'return array of one published game' do
        expect(described_class.published.size).to eq 1
      end
    end

    context 'when not exist a published game' do
      let!(:game_1) { create :game, status: :pending }
      let!(:game_2) { create :game, name: 'Game 2', status: :pending }
    end

    it 'return empty array' do
      expect(described_class.published.size).to eq 0
    end
  end

  describe '.by_status' do
    let!(:game_1) { create :game }
    let!(:game_2) { create :game, name: 'Game 2', status: :pending }
    let!(:game_3) { create :game, name: 'Game 3', status: :archived }

    it 'return array of one published game' do
      expect(described_class.by_status(:published)).to eq [game_1]
    end

    it 'return array of one pending game ' do
      expect(described_class.by_status(:pending)).to eq [game_2]
    end

    it 'return array of zero archived game' do
      expect(described_class.by_status(:archived)).to eq [game_3]
    end
  end
end
