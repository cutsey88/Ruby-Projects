require_relative 'board.rb'
require_relative 'pieces.rb'

class Game
  attr_accessor :board, :current_turn

  def initialize
    @board = Board.new
    @current_turn = 'white'
  end

  def place_pieces
    place_pawns
    place_rooks
    place_knights
    place_bishops
    place_queens
    place_kings
  end

  def place_pawns
    board.each do |column|
      column[1] = Pawn.new('white')
      column[6] = Pawn.new('black')
    end
  end

  def place_rooks
    board[0][0] = Rook.new('white')
    board[7][0] = Rook.new('white')
    board[0][7] = Rook.new('black')
    board[7][7] = Rook.new('black')
  end

  def place_knights
    board[1][0] = Knight.new('white')
    board[6][0] = Knight.new('white')
    board[1][7] = Knight.new('black')
    board[6][7] = Knight.new('black')
  end

  def place_bishops
    board[2][0] = Bishop.new('white')
    board[5][0] = Bishop.new('white')
    board[2][7] = Bishop.new('black')
    board[5][7] = Bishop.new('black')
  end

  def place_queens
    board[3][0] = Queen.new('white')
    board[4][7] = Queen.new('black')
  end

  def place_kings
    board[4][0] = King.new('white')
    board[3][7] = King.new('black')
  end

  def change_player_turn
    current_turn == 'white' ? self.current_turn = 'black' : self.current_turn = 'white'
  end
end
