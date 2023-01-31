# frozen_string_literal: true

class Companiable < ApplicationRecord
  # Associations
  belongs_to :game
  belongs_to :company
  belongs_to :publisher, foreign_key: 'company_id', optional: true
  belongs_to :developer, foreign_key: 'company_id', optional: true

  # Scopes
  scope :mains, -> { where(main: true) }
  scope :no_mains, -> { where(main: false) }

  # Validations
  validates :order, presence: true
end
