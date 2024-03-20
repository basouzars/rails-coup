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
require 'test_helper'

class CardTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
