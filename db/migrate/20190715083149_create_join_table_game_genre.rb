# frozen_string_literal: true

class CreateJoinTableGameGenre < ActiveRecord::Migration[5.2]
  def change
    create_join_table :games, :genres do |t|
      t.index [:game_id, :genre_id]
    end
  end
end
