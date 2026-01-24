class Board
  attr_reader :all_moves, :board

  WINNING_CORDS =
    [[0, 1, 2], [3, 4, 5], [6, 7, 8],
     [0, 3, 6], [1, 4, 7], [2, 5, 8],
     [0, 4, 8], [2, 4, 6]].freeze

  def initialize
    @board = %w[1 2 3 4 5 6 7 8 9]
    @all_moves = []
  end

  def winning_cords
    WINNING_CORDS
  end

  # displays board as rows and columns
  def display
    puts "============="
    puts " \"#{board[0]}\" \"#{board[1]}\" \"#{board[2]}\""
    puts "------*------"
    puts " \"#{board[3]}\" \"#{board[4]}\" \"#{board[5]}\""
    puts "------*------"
    puts " \"#{board[6]}\" \"#{board[7]}\" \"#{board[8]}\""
    puts "============="
  end

  def full?
    all_moves.size > 8
  end

  def valid_move?(move)
    !all_moves.include?(move) && move.between?(1, 9)
  end

  def assign_move(player, move)
    board[move - 1] = player.symbol
    all_moves << move
  end
end
