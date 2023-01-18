# frozen_string_literal: true

require 'rails_helper'

describe Platform do
  subject(:platform) { described_class.new }

  describe 'database columns' do
    it do
      expect(platform).to have_db_column(:name).of_type(:string)
      expect(platform).to have_db_column(:slug).of_type(:string)
      expect(platform).to have_db_column(:abbrv_name).of_type(:string)
      expect(platform).to have_db_column(:url).of_type(:string)
      expect(platform).to have_db_column(:status).of_type(:integer)
      expect(platform).to have_db_column(:manufactur_id).of_type(:integer)
    end
  end

  describe 'validates' do
    it do
      expect(platform).to validate_presence_of :name
      expect(platform).to validate_presence_of :abbrv_name
    end
  end
end
