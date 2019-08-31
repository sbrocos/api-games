# frozen_string_literal: true

class Company < ApplicationRecord
  include Statuable
  extend FriendlyId

  enum company_type: %i[default studio publisher]

  friendly_id :slug_candidates, use: :slugged

  # associations
  has_many :companiables
  has_many :games, through: :companiables

  # validates
  validates :name, presence: true

  private

  def slug_candidates
    [
      :name,
      [:name, :id]
    ]
  end
end
