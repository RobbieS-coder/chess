# frozen_string_literal: true

# Keeps track of the moves made
class MoveHistory
  def initialize(history = [])
    @history = history
  end

  def add_move; end

  def recent_moves
    @history[-4, 4]
  end
end
