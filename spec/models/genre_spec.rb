# frozen_string_literal: true

require 'rails_helper'

describe Genre, type: :model do
  describe 'database columns' do
    it do
      is_expected.to have_db_column(:name).of_type(:string)
      is_expected.to have_db_column(:slug).of_type(:string)
    end
  end

  describe 'associations' do
    it do
      is_expected.to have_and_belong_to_many(:games)
    end
  end

  describe 'validates' do
    it { is_expected.to validate_presence_of :name }
  end
end
