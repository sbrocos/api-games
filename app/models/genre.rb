# frozen_string_literal: true

class Genre < ApplicationRecord
  include Statuable
  extend FriendlyId

  has_and_belongs_to_many :games

  friendly_id :name, use: :slugged

  validates :name, presence: true
end
