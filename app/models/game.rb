# frozen_string_literal: true

class Game < ApplicationRecord
  include Statuable
  extend FriendlyId

  has_many :companiables
  has_many :companies, through: :companiables
  has_and_belongs_to_many :genres

  friendly_id :slug_candidates, use: :slugged

  # validations
  validates_presence_of :name

  private

    def slug_candidates
      [
        :name,
        [:name, :id],
      ]
    end
end
