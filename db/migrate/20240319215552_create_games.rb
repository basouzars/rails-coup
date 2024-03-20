# frozen_string_literal: true

class CreateGames < ActiveRecord::Migration[7.1]
  def change
    create_table :games, id: :uuid do |t|
      t.string :status
      t.integer :playable_position

      t.timestamps
    end
  end
end
