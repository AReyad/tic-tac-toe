class Board
  attr_accessor :board

  @all_moves = []

  WINNING_CORDS =
    [[1, 2, 3], [4, 5, 6], [7, 8, 9],
     [1, 4, 7], [2, 5, 8], [3, 6, 9],
     [1, 5, 9], [3, 5, 7]].freeze

  def initialize
    @board = %w[1 2 3 4 5 6 7 8 9]
  end

  def self.winning_cords
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

  class << self
    attr_reader :all_moves

    def analyze_move(player, move)
      if all_moves.include?(move) || !move.between?(1, 9)
        puts "Invalid move! Try again.".red
        player.valid_move = false
      else
        player.turn_over = true
        player.valid_move = true
        player.moves << move
        all_moves << move
      end
    end
  end
end
