require_relative 'board.rb'
require_relative 'pieces.rb'
require_relative 'display.rb'

class Game
  include Display
  attr_accessor :chess_board, :current_turn

  def initialize
    @chess_board = Board.new
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
    chess_board.board.each do |column|
      column[1] = Pawn.new('white')
      column[6] = Pawn.new('black')
    end
  end

  def place_rooks
    chess_board.board[0][0] = Rook.new('white')
    chess_board.board[7][0] = Rook.new('white')
    chess_board.board[0][7] = Rook.new('black')
    chess_board.board[7][7] = Rook.new('black')
  end

  def place_knights
    chess_board.board[1][0] = Knight.new('white')
    chess_board.board[6][0] = Knight.new('white')
    chess_board.board[1][7] = Knight.new('black')
    chess_board.board[6][7] = Knight.new('black')
  end

  def place_bishops
    chess_board.board[2][0] = Bishop.new('white')
    chess_board.board[5][0] = Bishop.new('white')
    chess_board.board[2][7] = Bishop.new('black')
    chess_board.board[5][7] = Bishop.new('black')
  end

  def place_queens
    chess_board.board[3][0] = Queen.new('white')
    chess_board.board[4][7] = Queen.new('black')
  end

  def place_kings
    chess_board.board[4][0] = King.new('white')
    chess_board.board[3][7] = King.new('black')
  end

  def play
    until checkmate?
      make_move
    end
  end

  def make_move
    target = target_input
    my_piece = chess_board.board[target[0]][target[1]]
    destination = destination_input(my_piece)
    move_piece(target, destination, my_piece)
  end

  def check?
    king_space = current_player_spaces.reduce { |result, space|
      break space if chess_board.board[space[0]][space[1]].is_a?(King)
    }
    opponent_spaces.reduce { |result, opp_piece|
      if legal_space(king_space, opp_piece, opponent_spaces, current_player_spaces)
        break true
      else
        false
      end
    }
  end

  def checkmate?
  end

  #Get the target space and return array with integer values (x, y)
  def target_input
    target_space = gets.chomp
    if verify_input(target_space)
      space_xy = shift_input(target_space)
      space_xy = target_input unless verify_space(space_xy)
    else
      space_xy = target_input
    end
    verify_piece(space_xy) ? space_xy : target_input
  end

  def shift_input(string_input)
    [string_input[0].to_i, string_input[1].to_i]
  end

  def destination_input(moving_piece)
    destination = gets.chomp
    if verify_input(destination)
      space_xy = shift_input(destination)
    else
      space_xy = destination_input
    end
    legal_space(space_xy, moving_piece, current_player_spaces, opponent_spaces) ? space_xy : destination_input
  end

  def current_player_spaces
    current_turn == 'white' ? chess_board.white_piece_spaces : chess_board.black_piece_spaces
  end

  def opponent_spaces
    current_turn == 'white' ? chess_board.black_piece_spaces : chess_board.white_piece_spaces
  end

  def verify_input(input)
    if input.length != 2
      puts wrong_length_message
      return false
    elsif !input.match(/\d\d/)
      puts wrong_char_message
      return false
    end
    true
  end

  #Take input as [x,y], check if space is on the board
  def input_on_board?(input)
    Board.all_board_spaces.include?(input)
  end

  def verify_space(space)
    if input_on_board?(space)
      true
    else
      puts not_on_board_message
      false
    end
  end

  def verify_piece(space)
    unless piece_in_space?(space)
      puts no_piece_message
      return false
    end
    unless piece_is_current_players?(space)
      puts not_your_piece_message
      return false
    end
    true
  end

  def legal_space(space, moving_piece, player_spaces, opp_spaces)
    possible_spaces = moving_piece.possible_moves(space, player_spaces, opp_spaces)
    if possible_spaces.include?(space)
      true
    else
      # move message : puts bad_destination_message
      false
    end
  end

  def piece_in_space?(input)
    chess_board.board[input[0]][input[1]].is_a?(Piece)
  end

  def piece_is_current_players?(input)
    input.color == current_turn
  end

  def move_piece(start_space, end_space, piece)
    chess_board.board[end_space[0]][end_space[1]] = piece
    chess_board.board[start_space[0]][start_space[1]] = 'empty'
  end

  #If I want to show which pieces were taken on the side of the board
  def take_piece
  end

  def change_player_turn
    current_turn == 'white' ? self.current_turn = 'black' : self.current_turn = 'white'
  end
end
