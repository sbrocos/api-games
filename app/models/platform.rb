# frozen_string_literal: true

class Platform < ApplicationRecord
  include Statuable
  extend FriendlyId

  friendly_id :name, use: :slugged

  validates :name, :abbrv_name, presence: true
end
