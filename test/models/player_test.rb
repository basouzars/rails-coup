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
require 'test_helper'

class PlayerTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
