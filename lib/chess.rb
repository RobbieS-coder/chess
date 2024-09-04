# frozen_string_literal: true

require_relative 'board'
require_relative 'player'
require_relative 'displayable'
require_relative 'ui'

# Contains the loop to play chess and interfaces with all main classes
class Chess
  include Displayable
  include UI

  def initialize(white = Player.new('white'), black = Player.new('black', white.name), board = Board.new)
    @board = board
    @white = white
    @black = black
    @current_player = @white
  end

  def play
    loop do
      display
      break if @board.game_over?(@current_player.colour)

      move = valid_player_input
      check_drawing_and_resigning(move)
      break if @resigning || @drawing

      handle_move(move)
      switch_player
    end
    @board.game_over?(@current_player.colour) ? announce_game_end : announce_other
  end

  private

  def valid_player_input
    loop do
      move = player_input
      return move if /[rd]/.match?(move)

      case @board.valid_move?(move, @current_player.colour)
      when true then return move
      when false then puts 'Invalid move pattern'
      when nil then puts 'Illegal move'
      end
    end
  end

  def check_drawing_and_resigning(move)
    case move
    when 'r' then @resigning = true
    when 'd' then @drawing = true if @board.valid_draw? || accept_draw?
    end
  end

  def handle_move(move)
    @board.update_board(move)
    @board.add_move(move)
  end

  def switch_player
    @current_player = other_player
  end

  def other_player
    @current_player == @white ? @black : @white
  end
end
