# frozen_string_literal: true

class Publisher < Company
  # Associations
  has_many :developers, foreign_key: 'parent_id'
end
