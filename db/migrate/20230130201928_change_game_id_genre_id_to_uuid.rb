# frozen_string_literal: true

#
class ChangeGameIdGenreIdToUuid < ActiveRecord::Migration[7.0]
  def up
    add_column :games_genres, :game_uuid, :uuid, default: 'gen_random_uuid()', null: false
    add_column :games_genres, :genre_uuid, :uuid, default: 'gen_random_uuid()', null: false

    remove_column :games_genres, :game_id
    remove_column :games_genres, :genre_id

    rename_column :games_genres, :game_uuid, :game_id
    rename_column :games_genres, :genre_uuid, :genre_id
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
