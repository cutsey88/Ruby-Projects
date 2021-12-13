
class Board
  attr_accessor :board
  def initialize
    @board = []
    8.times do
      @board.push(Array.new(8, 'empty'))
    end
  end
  @@board_spaces = (0..7).map { |i|
    (0..7).map { |j| [i,j] }
  }.flatten(1)

  def self.all_board_spaces
    @@board_spaces
  end

  def white_black_piece_spaces
    pieces = {
      white: [],
      black: []
    }
    board.each_with_index { |column, xi|
      column.each_with_index { |space, yi|
        next unless space.is_a?(Piece)
        if space.color == 'white'
          pieces[:white] << [xi, yi]
        else
          pieces[:black] << [xi, yi]
        end
      }
    }
    pieces
  end
end
