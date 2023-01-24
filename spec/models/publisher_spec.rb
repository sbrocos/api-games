# frozen_string_literal: true

require 'rails_helper'

describe Publisher, type: :model do
  context 'associations' do
    it { is_expected.to have_many(:developers).with_foreign_key(:parent_id) }
  end
end
