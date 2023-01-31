# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Company, type: :model do
  describe 'database columns' do
    it do
      is_expected.to have_db_column(:name).of_type(:string)
      is_expected.to have_db_column(:name_complete).of_type(:string)
      is_expected.to have_db_column(:slug).of_type(:string)
      is_expected.to have_db_column(:url).of_type(:string)
      is_expected.to have_db_column(:city).of_type(:string)
      is_expected.to have_db_column(:country).of_type(:string)
      is_expected.to have_db_column(:type).of_type(:string)
      is_expected.to have_db_column(:workflow_state).of_type(:string).with_options(null: false)
      is_expected.to have_db_column(:parent_id).of_type(:uuid)
    end
  end

  describe 'associations' do
    it do
      is_expected.to have_many(:companiables)
      is_expected.to have_many(:games).through(:companiables)
      is_expected.to have_many(:games).through(:companiables)
    end
  end

  describe 'validates' do
    it { is_expected.to validate_presence_of :name }
    it { is_expected.to validate_presence_of :name_complete }
  end
end
