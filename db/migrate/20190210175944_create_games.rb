# frozen_string_literal: true

class CreateGames < ActiveRecord::Migration[5.2]
  def change
    create_table :games, id: :uuid  do |t|
      t.string :name
      t.string :slug
      t.string :url
      t.integer :status, default: 0
      t.string :plot
      t.string :short_plot

      t.timestamps
    end

    add_index :games, :slug, unique: true
  end
end
