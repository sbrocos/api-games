# frozen_string_literal: true

# Class Model for Studios
class Developer < Company
  # Associations
  belongs_to :publisher, foreign_key: 'parent_id', optional: true

  def publisher_id
    parent_id
  end
end
