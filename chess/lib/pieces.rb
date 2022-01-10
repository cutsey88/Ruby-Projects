require_relative 'board.rb'

class Piece
  attr_reader :color, :symbol, :move_count
  def initialize(color)
    @color = color
    @move_count = 0
  end

  def assign_symbol(white_piece, black_piece)
    color == 'white' ? @symbol = white_piece : @symbol = black_piece
  end
  
  #Determine possible moves up, down, left, and right
  def up_down_right_left(current_space, player_pieces, opponent_pieces)
    moves = []
    player_up = assess_player_pieces(current_space, player_pieces, &up)
    player_down = assess_player_pieces(current_space, player_pieces, &down)
    player_right = assess_player_pieces(current_space, player_pieces, &right)
    player_left = assess_player_pieces(current_space, player_pieces, &left)
    opp_up = assess_opponent_pieces(current_space, opponent_pieces, &up)
    opp_down = assess_opponent_pieces(current_space, opponent_pieces, &down)
    opp_right = assess_opponent_pieces(current_space, opponent_pieces, &right)
    opp_left = assess_opponent_pieces(current_space, opponent_pieces, &left)
    player_up < opp_up ? player_up.each { |space| moves << space } : opp_up.each { |space| moves << space }
    player_down < opp_down ? player_down.each { |space| moves << space } : opp_down.each { |space| moves << space }
    player_right < opp_right ? player_right.each { |space| moves << space } : opp_right.each { |space| moves << space }
    player_left < opp_left ? player_left.each { |space| moves << space } : opp_left.each { |space| moves << space }
    moves
  end
  
  #Determine possible diagonal moves
  def diagonals(current_space, player_pieces, opponent_pieces)
    moves = []
    player_ur = assess_player_pieces(current_space, player_pieces, &diag_ur)
    player_ul = assess_player_pieces(current_space, player_pieces, &diag_ul)
    player_dr = assess_player_pieces(current_space, player_pieces, &diag_dr)
    player_dl = assess_player_pieces(current_space, player_pieces, &diag_dl)
    opp_ur = assess_opponent_pieces(current_space, opponent_pieces, &diag_ur)
    opp_ul = assess_opponent_pieces(current_space, opponent_pieces, &diag_ul)
    opp_dr = assess_opponent_pieces(current_space, opponent_pieces, &diag_dr)
    opp_dl = assess_opponent_pieces(current_space, opponent_pieces, &diag_dl)
    player_ur < opp_ur ? player_ur.each { |space| moves << space } : opp_ur.each { |space| moves << space }
    player_ul < opp_ul ? player_ul.each { |space| moves << space } : opp_ul.each { |space| moves << space }
    player_dr < opp_dr ? player_dr.each { |space| moves << space } : opp_dr.each { |space| moves << space }
    player_dl < opp_dl ? player_dl.each { |space| moves << space } : opp_dl.each { |space| moves << space }
    moves
  end

  #Determine possible moves based on location of the moving player's pieces
  def assess_player_pieces(current_space, player_pieces, &direction_block)
    moves = []
    inc = 1
    loop do
      potential_spot = direction_block.call(current_space, inc)
      if !player_pieces.include?(potential_spot) && Board.all_board_spaces.include?(potential_spot)
        moves << potential_spot
        inc += 1
      else
        break
      end
    end
    moves
  end

  #Determine possible moves based on location of the opponent player's pieces
  def assess_opponent_pieces(current_space, opponent_pieces, &direction_block)
    moves = []
    inc = 1
    loop do
      potential_spot = direction_block.call(current_space, inc)
      moves << potential_spot if Board.all_board_spaces.include?(potential_spot)
      if !opponent_pieces.include?(potential_spot) && Board.all_board_spaces.include?(potential_spot)
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
    assign_symbol("\u2659", "\u265F")
  end

  def possible_moves(current_space, player_pieces, opponent_pieces)
    moves = []
    potential_moves(current_space).each { |space|
      moves << space unless opponent_pieces.include?(space) ||
                            player_pieces.include?(space)
    }
    attack_moves(current_space).each { |space|
      moves << space if opponent_pieces.include?(space)
    }
    moves.map { |space| space if Board.all_board_spaces.include?(space) }
  end

  def potential_moves(current_space)
    moves = []
    if color == 'white'
      moves << [current_space[0], current_space[1] + 1]
      moves << [current_space[0], current_space[1] + 2] if move_count == 0
    else
      moves << [current_space[0], current_space[1] - 1]
      moves << [current_space[0], current_space[1] - 2] if move_count == 0
    end
    moves
  end

  def attack_moves(current_space)
    moves = []
    if color == 'white'
      moves << [current_space[0] + 1, current_space[1] + 1]
      moves << [current_space[0] - 1, current_space[1] + 1]
    else
      moves << [current_space[0] + 1, current_space[1] - 1]
      moves << [current_space[0] - 1, current_space[1] - 1]
    end
    moves
  end
end

class Rook < Piece
  def initialize(color)
    super(color)
    assign_symbol("\u2656", "\u265C")
  end

  def possible_moves(current_space, player_pieces, opponent_pieces)
    up_down_right_left(current_space, player_pieces, opponent_pieces)
  end
end

class Bishop < Piece
  def initialize(color)
    super(color)
    assign_symbol("\u2657", "\u265D")
  end

  def possible_moves(current_space, player_pieces, opponent_pieces)
    diagonals(current_space, player_pieces, opponent_pieces)
  end
end

class Knight < Piece
  def initialize(color)
    super(color)
    assign_symbol("\u2658", "\u265E")
  end

  def possible_moves(current_space, player_pieces, opponent_pieces)
    potential_moves(current_space).map do |space|
      space if !player_pieces.include?(space) && Board.all_board_spaces.include?(space)
    end
  end

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
  def initialize(color)
    super(color)
    assign_symbol("\u2655", "\u265B")
  end

  def possible_moves(current_space, player_pieces, opponent_pieces)
    moves = []
    up_down_right_left(current_space, player_pieces, opponent_pieces).each { 
      |space| moves << space }
    diagonals(current_space, player_pieces, opponent_pieces).each { 
      |space| moves << space }
    moves
  end
end

class King < Piece
  def initialize(color)
    super(color)
    assign_symbol("\u2654", "\u265A")
  end

  def possible_moves(current_space, player_pieces, opponent_pieces)
    potential_moves.map { |space| space unless player_pieces.include?(space) }
  end

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
    moves.map { |space| space if Board.all_board_spaces.include?(space) }
  end
end
