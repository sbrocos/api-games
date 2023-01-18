# frozen_string_literal: true

require 'rails_helper'

describe Game, type: :model do
  describe 'database columns' do
    it do
      is_expected.to have_db_column(:name).of_type(:string)
      is_expected.to have_db_column(:url).of_type(:string)
      is_expected.to have_db_column(:slug).of_type(:string)
      is_expected.to have_db_column(:status).of_type(:integer)
      is_expected.to have_db_column(:plot).of_type(:string)
      is_expected.to have_db_column(:short_plot).of_type(:string)
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
