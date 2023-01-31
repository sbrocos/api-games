# frozen_string_literal: true

# Class Model for Developers
class Developer < Company
  # Associations
  belongs_to :publisher, foreign_key: 'parent_id', optional: true
  has_many :companiables, foreign_key: 'company_id'

  def publisher_id
    parent_id
  end
end
