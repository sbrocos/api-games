# frozen_string_literal: true

class Game < ApplicationRecord
  include Statuable
  extend FriendlyId

  friendly_id :slug_candidates, use: :slugged

  # associations
  has_many :companiables
  has_many :companies, through: :companiables
  has_and_belongs_to_many :genres


  # validations
  validates_presence_of :name
  validates_uniqueness_of :name

  private

  def slug_candidates
    [
      :name,
      [:name, :id],
    ]
  end
end
