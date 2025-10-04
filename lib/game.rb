require_relative "board"
require_relative "player"

class Game
  attr_reader :game_board, :player1, :player2, :current_player

  @game_over = false

  def initialize
    print "Enter Player 1's name: "
    @player1 = Player.new(gets.chomp.capitalize.blue, "x".blue)
    print "Enter Player 2's name: "
    @player2 = Player.new(gets.chomp.capitalize.yellow, "o".yellow)
    @game_board = Board.new
    @current_player = player1
    @winner = nil
  end

  def play
    puts "Welcome to Tic-Tac-Toe"
    puts "-------------------"
    display_guide
    until game_over
      print "#{current_player.name}'s turn pick your position: "
      current_player.set_move(game_board, gets.chomp.to_i)
      swap_turn
    end
  end

  private

  def display_guide
    puts "Each player will be assigned a symbol X or O"
    puts "A player must pick a number from 1-9 to place his symbol on the board"
    game_board.display
  end

  def swap_turn
    if current_player.turn_over && current_player == player1
      @current_player = player2
    elsif current_player.turn_over && current_player == player2
      @current_player = player1
    end
  end

  def winner?(player)
    Board.winning_cords.any? do |cords|
      (cords - player.moves).empty?
    end
  end

  def assign_winner
    if winner?(player1)
      @winner = player1
    elsif winner?(player2)
      @winner = player2
    end
  end

  def game_over
    assign_winner
    if @winner
      @game_over = true
      puts "Player #{@winner.name} wins!"
    elsif Board.full?
      @game_over = true
      puts "Game ended with a draw!".yellow
    end
    @game_over
  end
end
