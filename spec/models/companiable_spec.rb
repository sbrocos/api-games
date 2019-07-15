# frozen_string_literal: true

require 'rails_helper'

describe Companiable, type: :model do
  context 'database columns' do
    it do
      is_expected.to have_db_column :game_id
      is_expected.to have_db_column :company_id
      is_expected.to have_db_column :order
    end
  end

  context 'associations' do
    it do
      is_expected.to belong_to(:game)
      is_expected.to belong_to(:company)
    end
  end

  context 'validates' do
    it { is_expected.to validate_presence_of :order }
  end
end
