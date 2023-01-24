# frozen_string_literal: true

require 'rails_helper'

describe Developer, type: :model do
  context 'associations' do
    it do
      is_expected.to belong_to(:publisher).with_foreign_key(:parent_id).optional
    end
  end
end
