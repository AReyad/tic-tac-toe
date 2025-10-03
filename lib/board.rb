class Board
  attr_accessor :board

  @game_over = false
  WINNING_CORDS =
    [[1, 2, 3], [4, 5, 6], [7, 8, 9],
     [1, 4, 7], [2, 5, 8], [3, 6, 9],
     [1, 5, 9], [3, 5, 7]]

  def initialize
    @board = Array.new(3) { Array.new(3, "") }
  end

  def self.game_over(player1, player2)
    if player1.winner || player2.winner
      @game_over = true
      puts "Player #{player1.name} Won!" if player1.winner
      puts "Player #{player2.name} Won!" if player2.winner
    elsif Player.all_moves.size > 8
      @game_over = true
      puts "Game ended with a draw!"
    end
    @game_over
  end

  def self.winning_cords
    WINNING_CORDS
  end

  def display_board
    board.each { |row| p row }
    puts "-------------------"
  end
end
