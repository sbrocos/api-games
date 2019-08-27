# frozen_string_literal: true

class CreatePlatforms < ActiveRecord::Migration[5.2]
  def change
    create_table :platforms, id: :uuid do |t|
      t.string :name
      t.string :slug
      t.string :abbrv_name
      t.string :url
      t.belongs_to :manufactur
      t.integer :status

      t.timestamps
    end

    add_index :platforms, :slug, unique: true
  end
end
