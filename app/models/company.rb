# frozen_string_literal: true

class Company < ApplicationRecord
  include Statuable
  extend FriendlyId

  friendly_id :slug_candidates, use: :slugged

  has_many :companiables
  has_many :games, through: :companiables

  validates :name, presence: true

  private

  def slug_candidates
    [
      :name,
      [:name, :id]
    ]
  end
end
