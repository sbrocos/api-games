# frozen_string_literal: true

class Company < ApplicationRecord
  include WorkflowActiverecord
  extend FriendlyId

  friendly_id :slug_candidates, use: :slugged

  # Workflow
  workflow do
    state :pending
    state :published
    state :archivied
  end

  # Associations
  has_many :companiables
  has_many :games, through: :companiables

  # Validations
  validates :name, :name_complete, presence: true

  private

  def slug_candidates
    [
      :name,
      [:name, :id]
    ]
  end
end
