# frozen_string_literal: true

class CreateMoves < ActiveRecord::Migration[7.1]
  def change
    create_table :moves, id: :uuid do |t|
      t.references :game, foreign_key: true, type: :uuid
      t.references :player, foreign_key: true, type: :uuid
      t.string :name
      t.references :target_player, foreign_key: { to_table: :players }, null: true, type: :uuid
      t.boolean :success

      t.timestamps
    end
  end
end
