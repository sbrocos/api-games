# frozen_string_literal: true

class RemoveStatusAndAddWorflowState < ActiveRecord::Migration[7.0]
  def change
    remove_column :games, :status, :integer
    remove_column :platforms, :status, :integer

    add_column :games, :workflow_state, :string, null: false
    add_column :platforms, :workflow_state, :string, null: false
    add_column :users, :workflow_state, :string, null: false
  end
end
