
class Board
  attr_accessor :board
  def initialize
    @board = []
    8.times do
      @board.push(Array.new(8))
    end
  end
end
