class Board
  attr_accessor :spaces
  def initialize
    @spaces = []
    7.times do
      @spaces.push(Array.new(6))
    end
  end

  def show_board
    puts <<~HEREDOC
      --1-+-2-+-3-+-4-+-5-+-6-+-7--
      | #{spaces[0][5] || ' '} | #{spaces[1][5] || ' '} | #{spaces[2][5] || ' '} | #{spaces[3][5] || ' '} | #{spaces[4][5] || ' '} | #{spaces[5][5] || ' '} | #{spaces[6][5] || ' '} |
      |---+---+---+---+---+---+---|
      | #{spaces[0][4] || ' '} | #{spaces[1][4] || ' '} | #{spaces[2][4] || ' '} | #{spaces[3][4] || ' '} | #{spaces[4][4] || ' '} | #{spaces[5][4] || ' '} | #{spaces[6][4] || ' '} |
      |---+---+---+---+---+---+---|
      | #{spaces[0][3] || ' '} | #{spaces[1][3] || ' '} | #{spaces[2][3] || ' '} | #{spaces[3][3] || ' '} | #{spaces[4][3] || ' '} | #{spaces[5][3] || ' '} | #{spaces[6][3] || ' '} |
      |---+---+---+---+---+---+---|
      | #{spaces[0][2] || ' '} | #{spaces[1][2] || ' '} | #{spaces[2][2] || ' '} | #{spaces[3][2] || ' '} | #{spaces[4][2] || ' '} | #{spaces[5][2] || ' '} | #{spaces[6][2] || ' '} |
      |---+---+---+---+---+---+---|
      | #{spaces[0][1] || ' '} | #{spaces[1][1] || ' '} | #{spaces[2][1] || ' '} | #{spaces[3][1] || ' '} | #{spaces[4][1] || ' '} | #{spaces[5][1] || ' '} | #{spaces[6][1] || ' '} |
      |---+---+---+---+---+---+---|
      | #{spaces[0][0] || ' '} | #{spaces[1][0] || ' '} | #{spaces[2][0] || ' '} | #{spaces[3][0] || ' '} | #{spaces[4][0] || ' '} | #{spaces[5][0] || ' '} | #{spaces[6][0] || ' '} |
    HEREDOC
  end
end

