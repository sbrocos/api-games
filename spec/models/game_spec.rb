# frozen_string_literal: true

require 'rails_helper'

describe Game, type: :model do
  describe 'database columns' do
    it do
      is_expected.to have_db_column :name
      is_expected.to have_db_column :url
      is_expected.to have_db_column :slug
      is_expected.to have_db_column :status
      is_expected.to have_db_column :plot
      is_expected.to have_db_column :short_plot
    end
  end

  describe 'associations' do
    it do
      is_expected.to have_many(:companiables)
      is_expected.to have_many(:companies).through(:companiables)
      is_expected.to have_and_belong_to_many(:genres)
    end
  end

  describe 'validates' do
    it { is_expected.to validate_presence_of :name }
  end

  it_behaves_like 'statuable', :game
end
