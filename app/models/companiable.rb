# frozen_string_literal: true

class Companiable < ApplicationRecord
  # Associations
  belongs_to :game
  belongs_to :company

  # Scopes
  scope :mains, -> { where(main: true) }
  scope :no_mains, -> { where(main: false) }

  # Validations
  validates :order, presence: true
end
