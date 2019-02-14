# frozen_string_literal: true

module Statuable
  extend ActiveSupport::Concern

  included do
    enum status: %i[pending published archived]

    scope :by_status, lambda { |status| where(status: status) }
    scope :published, -> { where(status: 'published') }
  end
end
