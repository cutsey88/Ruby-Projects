
class Board
  attr_accessor :board
  def initialize
    @board = []
    8.times do
      @board.push(Array.new(8, 'empty'))
    end
  end
  @@board_spaces = (0..7).map {
    |i| (0..7).map {
      |j| [i,j]
    }
  }.flatten(1)

  def self.all_board_spaces
    @@board_spaces
  end
end
