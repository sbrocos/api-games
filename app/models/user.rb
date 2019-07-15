# frozen_string_literal: true

class User < ApplicationRecord
  include RailsJwtAuth::Authenticatable
  validates :email, presence: true,
            uniqueness: true,
            format: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
end
