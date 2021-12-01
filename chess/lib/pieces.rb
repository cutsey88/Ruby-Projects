
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
end

class Rook < Piece
end

class Bishop < Piece
end

class Knight < Piece
end

class Queen < Piece
end

class King < Piece
end
