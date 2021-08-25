# frozen_string_literal: true

# Mastermind board
class Board
  attr_accessor :code_row, :key_row, :guess_row

  def initialize
    @code_row = []
    @key_row = []
    @guess_row = []
  end

  def show_key_row
    puts key_row
  end

end
