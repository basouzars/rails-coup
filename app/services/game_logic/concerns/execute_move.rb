# frozen_string_literal: true

module ExecuteMove
  extend ActiveSupport::Concern

  def execute_move(move, player, target_player = nil)
    return false unless valid_move?(move, player, target_player)

    move.target = target_player
    move.success = true
    move.save

    execute_action(move, player, target_player)
  end

  private

  def execute_swap_influences(player)
    @game.cards.in_deck.sample(2).each do |card|
      card.draw!(player)
    end
    player.cards.sample(2).each(&:return_to_deck!)
  end

  def execute_income(player)
    player.add_coins(1)
  end

  def execute_foreign_aid(player)
    player.add_coins(2)
  end

  def execute_taxes(player)
    player.add_coins(3)
  end

  def execute_steal(player, target_player)
    player.add_coins(2)
    target_player.remove_coins(2)
  end

  def execute_assassinate(player, target_player)
    player.remove_coins(3)

    reveal_player_card!(target_player)
  end

  def execute_coupe(player, target_player)
    player.remove_coins(7)

    reveal_player_card!(target_player)
  end

  def reveal_player_card!(player)
    hidden_cards = player.cards.hidden
    hidden_cards_amount = hidden_cards.count

    player.dies! if hidden_cards_amount == 1

    hidden_cards.first.reveals!
  end
end
