# frozen_string_literal: true

class CreateCompanies < ActiveRecord::Migration[5.2]
  def change
    create_table :companies, id: :uuid do |t|
      t.integer :company_type
      t.string :name
      t.string :slug
      t.string :url
      t.string :city
      t.string :country
      t.integer :status

      t.timestamps
    end

    add_index :companies, :slug, unique: true
  end
end
