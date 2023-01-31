# frozen_string_literal: true

require 'rails_helper'

describe Publisher, type: :model do
  describe 'database columns' do
    it do
      is_expected.to have_db_column(:parent_id).of_type(:uuid)
    end
  end

  describe 'associations' do
    it { is_expected.to have_many(:developers).with_foreign_key(:parent_id) }
  end
end
