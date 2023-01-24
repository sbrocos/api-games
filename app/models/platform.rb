# frozen_string_literal: true

class Platform < ApplicationRecord
  include WorkflowActiverecord
  extend FriendlyId

  friendly_id :name, use: :slugged

  # Workflow
  workflow do
    state :pending
    state :published
    state :archivied
  end

  # Validations
  validates :name, :abbrv_name, presence: true
end
