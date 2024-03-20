# frozen_string_literal: true

# == Schema Information
#
# Table name: actions
#
#  id               :uuid             not null, primary key
#  success          :boolean
#  name             :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  player_id        :uuid
#  target_player_id :uuid
#
# Indexes
#
#  index_actions_on_game_id           (game_id)
#  index_actions_on_player_id         (player_id)
#  index_actions_on_target_player_id  (target_player_id)
#
# Foreign Keys
#
#  fk_rails_...  (game_id => games.id)
#  fk_rails_...  (player_id => players.id)
#  fk_rails_...  (target_player_id => players.id)
#
class Move < ApplicationRecord
  TYPES = {
    start_round_options: %w[income coup taxes steal assassinate swap_influence foreign_aid],
    response_options: %w[challenge block_steal block_assassinate block_foreign_aid]
  }.freeze

  belongs_to :player
  belongs_to :target, class_name: 'Player', optional: true
  belongs_to :game

  validates :type, presence: true, inclusion: { in: TYPES.values.flatten }

  def to_s
    "#{name} from #{player}#{target ? " to #{target}" : ''}"
  end

  def can_be_blocked?
    TYPES.response_options.includes?(block_action_name)
  end

  def can_be_challenged?
    %w[coup income].excludes?(name)
  end

  def possible_responses
    responses = []

    responses << block_action_name if can_be_blocked?
    responses << 'challenge' if can_be_challenged?

    responses
  end

  def block_action_name
    "block_#{name}"
  end
end
