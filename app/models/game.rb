# frozen_string_literal: true

class Game < ApplicationRecord
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
  has_many :companies, -> { where(type: nil) }, through: :companiables
  has_many :publishers, through: :companiables
  has_many :developers, through: :companiables

  has_and_belongs_to_many :genres

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
