# frozen_string_literal: true

# == Schema Information
#
# Table name: players
#
#  id         :uuid             not null, primary key
#  alive      :boolean
#  coins      :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  game_id    :uuid
#  user_id    :uuid
#
# Indexes
#
#  index_players_on_game_id  (game_id)
#  index_players_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (game_id => games.id)
#  fk_rails_...  (user_id => users.id)
#
class Player < ApplicationRecord
  has_many :cards, dependent: :restrict_with_exception
  belongs_to :game
  belongs_to :user

  delegate :to_s, to: :user

  def public_info
    { username: user.username, coins:, alive:, position: }
  end

  def dies!
    update!(alive: false)
  end

  def add_coins(amount)
    update!(coins: coins + amount)
  end

  def remove_coins(amount)
    update!(coins: coins - amount)
  end
end
