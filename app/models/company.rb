class Company < ApplicationRecord
  include Statuable
  extend FriendlyId

  friendly_id :name, use: :slugged
end