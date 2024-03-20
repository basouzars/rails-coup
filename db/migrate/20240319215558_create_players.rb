# frozen_string_literal: true

class CreatePlayers < ActiveRecord::Migration[7.1]
  def change
    create_table :players, id: :uuid do |t|
      t.references :user, foreign_key: true, type: :uuid
      t.references :game, foreign_key: true, type: :uuid
      t.boolean :alive
      t.integer :coins
      t.integer :position

      t.timestamps
    end

    add_reference :games, :winner, foreign_key: { to_table: :players }, type: :uuid
  end
end
