# frozen_string_literal: true

class AddMainToCompaniable < ActiveRecord::Migration[7.0]
  def change
    add_column :companiables, :main, :boolean, default: false
  end
end
