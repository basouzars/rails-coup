# frozen_string_literal: true

module StartGame
  extend ActiveSupport::Concern

  def start_game!(users)
    return false unless can_start_game?

    create_players(users)
    create_start_cards

    update!(status: :started)
  end

  private

  def can_start_game?
    return false if started?
    return false if players.count < 2
    return false if players.count > 8

    true
  end

  def create_players(users)
    position = 0

    users.shuffle!
    users.map do |user|
      position += 1
      @game.players.create(user:, coins: 2, alive: true, position:)
    end
  end

  def create_start_cards
    deck = Card::TYPES.flat_map { |type| [type] * number_of_card_replicas }
    @start_cards = deck.map { |type| Card.create(type:, game: self) }
  end

  def number_of_card_replicas
    return 2 if players.size <= 3
    return 3 if players.size <= 5

    4
  end

  def deal_cards_and_publish
    players.each do |player|
      player.cards = @start_cards.pop(2)
      @game.publish_player_message(player)
    end
  end
end
