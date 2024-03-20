# frozen_string_literal: true

class CreateCards < ActiveRecord::Migration[7.1]
  def change
    create_table :cards, id: :uuid do |t|
      t.string :type
      t.string :revealed
      t.references :game, foreign_key: true, type: :uuid
      t.references :player, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
