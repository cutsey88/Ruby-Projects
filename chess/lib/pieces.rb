
class Piece
  attr_reader :color, :symbol
  def initialize(color)
    @color = color
  end

  def assign_symbol(white_piece, black_piece)
    color == 'white' ? @symbol = white_piece : @symbol = black_piece
  end
end

class Pawn < Piece
  def initialize(color)
    super(color)
    #whiteunicode = whitesym
    #blackunicode = blacksym
    assign_symbol(#whiteunicode,blackunicode)
  end

  def possible_move?
  end

  def potential_moves(current_space)
    moves = []
    moves
  end
end

class Rook < Piece

  def potential_moves
    moves = []
    moves
  end
end

class Bishop < Piece
end

class Knight < Piece
end

class Queen < Piece
end

class King < Piece
end
