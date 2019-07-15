# frozen_string_literal: true

class CreateCompaniables < ActiveRecord::Migration[5.2]
  def change
    create_table :companiables, id: :uuid do |t|
      t.references :game, foreign_key: true, type: :uuid
      t.references :company, foreign_key: true, type: :uuid
      t.integer :order

      t.timestamps
    end
  end
end
