# frozen_string_literal: true

require 'rails_helper'

describe Company, type: :model do
  describe 'database columns' do
    it do
      is_expected.to have_db_column :name
      is_expected.to have_db_column :slug
      is_expected.to have_db_column :url
      is_expected.to have_db_column :city
      is_expected.to have_db_column :country
      is_expected.to have_db_column :status
    end
  end

  describe 'associations' do
    it do
      is_expected.to have_many(:companiables)
      is_expected.to have_many(:games).through(:companiables)
    end
  end

  describe 'validates' do
    it { is_expected.to validate_presence_of :name }
  end

  it_behaves_like 'statuable', :company
end
