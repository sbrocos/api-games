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
      is_expected.to belong_to(:publisher).with_foreign_key(:company_id).optional
      is_expected.to belong_to(:developer).with_foreign_key(:company_id).optional
    end
  end

  describe 'validates' do
    it { is_expected.to validate_presence_of(:order) }
  end

  # START SCOPES
  describe '.mains' do
    subject(:mains) { described_class.mains }

    include_context :last_of_us_complete

    it { expect(mains).to eq [naughty_developer_companiable] }
  end

  describe '.no_mains' do
    subject(:no_mains) { described_class.no_mains }

    include_context :last_of_us_complete

    it { expect(no_mains).to eq [sony_publisher_companiable] }
  end
  # END SCOPES
end
