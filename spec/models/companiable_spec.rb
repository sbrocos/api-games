# frozen_string_literal: true

require 'rails_helper'

describe Companiable, type: :model do
  describe 'database columns' do
    it do
      is_expected.to have_db_column(:game_id).of_type(:uuid)
      is_expected.to have_db_column(:company_id).of_type(:uuid)
      is_expected.to have_db_column(:order).of_type(:integer)
    end
  end

  describe 'associations' do
    it do
      is_expected.to belong_to(:game)
      is_expected.to belong_to(:company)
    end
  end

  describe 'validates' do
    it { is_expected.to validate_presence_of(:order) }
  end
end
