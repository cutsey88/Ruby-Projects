# frozen_string_literal: true

# Contains logic for Computer
class ComputerPlayer
  attr_reader :board

  def initialize
    @code_pegs = %w[red orange yellow green blue purple]
    @key_pegs = %w[black white]
    @board = Board.new
  end

  def choose_code_pegs
    @chosen_pegs = []
    4.times do
      @chosen_pegs.push(@code_pegs.sample)
    end
  end


  def place_code_pegs
    @board.update_code_board(@chosen_pegs)
  end

  def place_key_pegs
    
    @board.update_key_board(somethingxxx)
  end
end
