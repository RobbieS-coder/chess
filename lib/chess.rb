# frozen_string_literal: true

require_relative 'board'
require_relative 'player'
require_relative 'displayable'
require_relative 'ui'
require_relative 'move_history'
require_relative 'serialiser'

# Contains the loop to play chess and interfaces with all main classes
class Chess
  include Displayable
  include UI

  def initialize(white = Player.new('white'), black = Player.new('black', white.name), history = nil)
    @move_history = MoveHistory.new
    @board = Board.new(@move_history)
    @white = white
    @black = black
    history&.each { |move| handle_move(move) }
    @current_player = @move_history.first_player == 'white' ? @white : @black
  end

  def play
    move = game_loop
    case move
    when 'r' then announce_resignation
    when 'd' then announce_draw
    else announce_game_end
    end
  end

  private

  def game_loop
    loop do
      display
      return if @board.game_over?(@current_player.colour)

      move = valid_player_input

      return move if move == 'r' || (move == 'd' && accept_draw?)

      Serialiser.save_game(@white.name, @black.name, @move_history.serialised_history) if move == 's'
      next if %w[d s].include?(move)

      handle_move(move)
      switch_player
    end
  end

  def valid_player_input
    loop do
      move = player_input
      return move if /^[rds]$/.match?(move)

      case @board.valid_move?(move, @current_player.colour)
      when true then return move
      when false then puts 'Invalid move pattern'
      when nil then puts 'Illegal move'
      end
    end
  end

  def handle_move(move)
    @board.update_board(move)
    @move_history.add_move(move)
  end

  def switch_player
    @current_player = other_player
  end

  def other_player
    @current_player == @white ? @black : @white
  end
end
