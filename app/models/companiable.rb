# frozen_string_literal: true

class Companiable < ApplicationRecord
  belongs_to :game
  belongs_to :company

  validates :order, presence: true
end
