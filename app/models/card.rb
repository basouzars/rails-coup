# frozen_string_literal: true

# == Schema Information
#
# Table name: cards
#
#  id         :uuid             not null, primary key
#  type       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  game_id    :uuid
#  player_id  :uuid
#
# Indexes
#
#  index_cards_on_game_id    (game_id)
#  index_cards_on_player_id  (player_id)
#
# Foreign Keys
#
#  fk_rails_...  (game_id => games.id)
#  fk_rails_...  (player_id => players.id)
#
class Card < ApplicationRecord
  belongs_to :player, optional: true
  belongs_to :game

  validates :type, presence: true, inclusion: { in: TYPES }

  TYPES = %w[Duke Assassin Captain Ambassador Contessa].freeze

  scope :hidden, -> { where(revealed: false) }
  scope :in_deck, -> { where(player: nil) }

  def to_s
    type
  end

  def reveals!
    update!(revealed: true)
  end

  def draw(player)
    update!(player:)
  end

  def return_to_deck
    update!(player: nil, revealed: false)
  end
end
