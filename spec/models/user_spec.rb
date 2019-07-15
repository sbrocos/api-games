# frozen_string_literal: true

require 'rails_helper'

describe User, type: :model do
  context 'associations' do
  end

  context 'database columns' do
    it do
      is_expected.to have_db_column(:email)
      is_expected.to have_db_column(:password_digest)
      is_expected.to have_db_column(:auth_tokens)
    end
  end

  context 'validations' do
    it do
      is_expected.to validate_presence_of(:email)
    end
  end
end
