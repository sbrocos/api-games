# frozen_string_literal: true

class ChangeFieldsInCompany < ActiveRecord::Migration[7.0]
  def change
    rename_column :companies, :status, :integer
    remove_column :companies, :company_type, :integer

    add_column :companies, :parent_id, :uuid
    add_column :companies, :workflow_state, :string, null: false
    add_column :companies, :type, :string
    add_column :companies, :name_complete, :string
    add_column :companies, :description, :text
  end
end
