require_relative 'board.rb'

class Piece
  attr_reader :color, :symbol
  def initialize(color)
    @color = color
  end

  def assign_symbol(white_piece, black_piece)
    color == 'white' ? @symbol = white_piece : @symbol = black_piece
  end

  def directional_potential(current_space, &direction_block)
    moves = []
    inc = 1
    loop do
      potential_spot = direction_block.call(current_space, inc)
      if Board.all_board_spaces.include?(potential_spot)
        moves << potential_spot
        inc += 1
      else
        break
      end
    end
    moves
  end

  def assess_player_pieces(current_space, player_pieces, &direction_block)
    moves = []
    inc = 1
    loop do
      potential_spot = direction_block.call(current_space, inc)
      if !player_pieces.include?(potential_spot)
        moves << potential_spot
        inc += 1
      else
        break
      end
    end
    moves
  end

  def assess_opponent_pieces(current_space, opponent_pieces, &direction_block)
    moves = []
    inc = 1
    loop do
      potential_spot = direction_block.call(current_space, inc)
      moves << potential_spot
      if !opponent_pieces.include?(potential_spot)
        inc += 1
      else
        break
      end
    end
    moves
  end

  up = Proc.new { |space, inc| [space[0], space[1] + inc] }
  down = Proc.new { |space, inc| [space[0], space[1] - inc] }
  right = Proc.new { |space, inc| [space[0] + inc, space[1]] }
  left = Proc.new { |space, inc| [space[0] - inc, space[1]] }
  diag_ur = Proc.new { |space, inc| [space[0] + inc, space[1] + inc] }
  diag_ul = Proc.new { |space, inc| [space[0] - inc, space[1] + inc] }
  diag_dr = Proc.new { |space, inc| [space[0] + inc, space[1] - inc] }
  diag_dl = Proc.new { |space, inc| [space[0] - inc, space[1] - inc] }
end

class Pawn < Piece
  def initialize(color)
    super(color)
    #whiteunicode = whitesym
    #blackunicode = blacksym
    assign_symbol(#whiteunicode,blackunicode)
  end

  def potential_moves(current_space)
    moves = []
    moves
  end
end

#finish
def up_down_right_left(current_space, player_pieces, opponent_pieces)
  moves = []
  up
  moves
end

class Rook < Piece
  def possible_moves(current_space, player_pieces, opponent_pieces)
    potentials = potential_moves(current_space)
    player_based = assess_player_pieces(current_space,player_pieces) 
    opponent_based = 
  end

  def potential_moves(current_space)
    moves = []
    directional_potential(current_space, &up).each { |space| moves << space }
    directional_potential(current_space, &down).each { |space| moves << space }
    directional_potential(current_space, &left).each { |space| moves << space }
    directional_potential(current_space, &right).each { |space| moves << space }
    moves
  end
end

class Bishop < Piece
  def potential_moves(current_space)
    moves = []
    directional_potential(current_space, &diag_ur).each { |space| moves << space }
    directional_potential(current_space, &diag_ul).each { |space| moves << space }
    directional_potential(current_space, &diag_dr).each { |space| moves << space }
    directional_potential(current_space, &diag_dl).each { |space| moves << space }
    moves
  end
end

class Knight < Piece
  def potential_moves(current_space)
    moves = []
    moves << [current_space[0] + 1, current_space[1] + 2]
    moves << [current_space[0] + 1, current_space[1] - 2]
    moves << [current_space[0] - 1, current_space[1] - 2]
    moves << [current_space[0] - 1, current_space[1] + 2]
    moves << [current_space[0] + 2, current_space[1] + 1]
    moves << [current_space[0] + 2, current_space[1] - 1]
    moves << [current_space[0] - 2, current_space[1] - 1]
    moves << [current_space[0] - 2, current_space[1] + 1]
    moves
  end
end

class Queen < Piece
  def potential_moves(current_space)
    moves = []
    directional_potential(current_space, &up).each { |space| moves << space }
    directional_potential(current_space, &down).each { |space| moves << space }
    directional_potential(current_space, &left).each { |space| moves << space }
    directional_potential(current_space, &right).each { |space| moves << space }
    directional_potential(current_space, &diag_ur).each { |space| moves << space }
    directional_potential(current_space, &diag_ul).each { |space| moves << space }
    directional_potential(current_space, &diag_dr).each { |space| moves << space }
    directional_potential(current_space, &diag_dl).each { |space| moves << space }
    moves
  end
end

class King < Piece
  def potential_moves(current_space)
    moves = []
    moves << [current_space[0] + 1, current_space[1]]
    moves << [current_space[0] - 1, current_space[1]]
    moves << [current_space[0], current_space[1] + 1]
    moves << [current_space[0], current_space[1] - 1]
    moves << [current_space[0] + 1, current_space[1] + 1]
    moves << [current_space[0] - 1, current_space[1] + 1]
    moves << [current_space[0] + 1, current_space[1] - 1]
    moves << [current_space[0] - 1, current_space[1] - 1]
    moves
  end
end
