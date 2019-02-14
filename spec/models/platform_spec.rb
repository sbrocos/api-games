# frozen_string_literal: true

require 'rails_helper'

describe Platform, type: :model do
  context 'associations' do
  end

  context 'database columns' do
    it do
      is_expected.to have_db_column :name
      is_expected.to have_db_column :slug
      is_expected.to have_db_column :abbrv_name
      is_expected.to have_db_column :url
      is_expected.to have_db_column :status
      is_expected.to have_db_column :manufactur_id
    end
  end

  context 'validates' do
    it do
      is_expected.to validate_presence_of :name
      is_expected.to validate_presence_of :abbrv_name
      is_expected.to validate_presence_of :slug
    end
  end
end
