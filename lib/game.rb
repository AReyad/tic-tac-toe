require_relative "board"
require_relative "player"

class Game
  attr_reader :game_board, :player1, :player2

  @game_over = false

  def initialize
    print "Enter Player 1's name: "
    @player1 = Player.new(gets.chomp.capitalize.blue, "x".blue)
    print "Enter Player 2's name: "
    @player2 = Player.new(gets.chomp.capitalize.yellow, "o".yellow)
    @game_board = Board.new
  end

  def play
    puts "Welcome to Tic-Tac-Toe"
    puts "-------------------"
    display_guide
    swap_turn until game_over
  end

  private

  def display_guide
    puts "Each player will be assigned a symbol X or O"
    puts "A player must pick a number from 1-9 to place his symbol on the board"
    game_board.display
  end

  def swap_turn
    if player2.turn_over
      print "#{player1.name}'s turn pick your position: "
      player1.set_move(game_board, gets.chomp.to_i)
      validate_move(player2, player1)
    else
      print "#{player2.name}'s turn pick your position: "
      player2.set_move(game_board, gets.chomp.to_i)
      validate_move(player1, player2)
    end
  end

  def validate_move(other_player, current_player)
    other_player.turn_over = false if current_player.valid_move == true
  end

  def winner?(player)
    Board.winning_cords.any? do |cords|
      (cords - player.moves).empty?
    end
  end

  def game_over
    if winner?(player1)
      @game_over = true
      puts "Player #{player1.name} wins!"
    elsif winner?(player2)
      @game_over = true
      puts "Player #{player2.name} wins!"
    elsif Board.all_moves.size > 8
      @game_over = true
      puts "Game ended with a draw!".yellow
    end
    @game_over
  end
end
