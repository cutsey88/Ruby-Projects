# frozen_string_literal: true

# Mastermind board
class Board
  attr_accessor :code_row, :guess_row

  def initialize
    @code_row = []
    @guess_row = []
  end

  def game_over?
    code_row == @guess_row
  end

end
