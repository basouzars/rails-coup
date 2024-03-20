# frozen_string_literal: true

class GameLogicService
  include StartGame

  def initialize(game)
    @game = game
  end

  def player_round_info(player)
    {
      player: {
        **player.public_info,
        cards: player.cards,
        id: player.id,
        possible_moves: possible_moves(player)
      },
      other_players: @game.players.map(&:public_info),
      current_player: current_player.to_s,
      game_status: @game.status
    }
  end

  private

  def possible_moves(player)
    return [] unless can_play?(player)

    return @last_move.possible_responses if @round_has_move

    Move::TYPES.start_round
  end

  def can_play?(player)
    return false unless player.alive?

    @last_move = last_move_last_round
    @round_has_move = @last_move.round == @game.round

    return @last_move.player != player if @round_has_move

    current_player == player
  end

  def current_player
    last_position = first_move_last_round.player.position
    players_query = players.alive.order(position: :asc)
    next_player = players_query.where('position > ?', last_position).first
    return next_player if next_player

    players_query.first
  end

  def first_move_last_round
    last_round_moves.min_by(&:created_at).first
  end

  def last_move_last_round
    last_round_moves.max_by(&:created_at).first
  end

  def last_round_moves
    @game.moves.max_by(&:round)
  end
end
