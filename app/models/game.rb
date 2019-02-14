# frozen_string_literal: true

class Game < ApplicationRecord
  include Statuable
  extend FriendlyId

  friendly_id :name, use: :slugged

  # validations
  validates_presence_of :name
end
