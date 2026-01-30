class Board
  attr_reader :all_moves, :board

  WINNING_CORDS =
    [[0, 1, 2], [3, 4, 5], [6, 7, 8],
     [0, 3, 6], [1, 4, 7], [2, 5, 8],
     [0, 4, 8], [2, 4, 6]].freeze

  def initialize
    @board = Array.new(8)
  end

  def winning_cords
    WINNING_CORDS
  end

  # displays board as rows and columns
  def display
    puts '============='
    puts " \"#{board[0] || 1}\" \"#{board[1] || 2}\" \"#{board[2] || 3}\""
    puts '------*------'
    puts " \"#{board[3] || 4}\" \"#{board[4] || 5}\" \"#{board[5] || 6}\""
    puts '------*------'
    puts " \"#{board[6] || 7}\" \"#{board[7] || 8}\" \"#{board[8] || 9}\""
    puts '============='
  end

  def full?
    board.none?(&:nil?)
  end

  def valid_move?(move)
    board[move - 1].nil? && move.between?(1, 9)
  end

  def assign_move(player, move)
    board[move - 1] = player.symbol
  end
end
