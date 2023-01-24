# frozen_string_literal: true

class Genre < ApplicationRecord
  extend FriendlyId

  friendly_id :name, use: :slugged

  # Associations
  has_and_belongs_to_many :games

  # Validations
  validates :name, presence: true
end
