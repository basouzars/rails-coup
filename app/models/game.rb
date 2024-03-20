# frozen_string_literal: true

# == Schema Information
#
# Table name: games
#
#  id         :uuid             not null, primary key
#  status     :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  winner_id  :uuid
#
# Indexes
#
#  index_games_on_winner_id  (winner_id)
#
# Foreign Keys
#
#  fk_rails_...  (winner_id => players.id)
#
class Game < ApplicationRecord
  belongs_to :winner, class_name: 'User', optional: true
  has_many :players, dependent: :restrict_with_exception
  has_many :moves, dependent: :restrict_with_exception
  has_many :cards, dependent: :restrict_with_exception

  def publish_message_to_all_players(message)
    players.each do |player|
      publish_player_message(player, message)
    end
  end

  def publish_player_message(player, message)
    ActionCable.server.broadcast(
      "game_channel_#{id}_#{player.id}",
      message
    )
  end
end
