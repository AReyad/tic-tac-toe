require_relative 'board'
require_relative 'player'

class Game
  def initialize(player_one = create_player(1, 'x', :blue), player_two = create_player(2, 'o', :yellow),
                 board = Board.new)
    @player1 = player_one
    @player2 = player_two
    @game_board = board
    @current_player = randomize_first_turn
    @winner = nil
  end

  def play
    starter_display
    until game_over?
      print "#{current_player.name}'s turn pick your position: "
      player_move = current_player.move
      next puts invalid_move unless game_board.valid_move?(player_move)

      make_move(player_move)
      check_and_assign_winner(current_player)
      swap_turn
    end
    final_message
  end

  def invalid_move
    'Invalid move! Try again.'.red
  end

  def make_move(move)
    game_board.assign_move(current_player, move)
    game_board.display
  end

  def winner?(player)
    game_board.winning_cords.any? do |cords|
      cords.all? { |cord| game_board.board[cord] == player.symbol }
    end
  end

  def check_and_assign_winner(player)
    self.winner = player if winner?(player)
  end

  def game_over?
    !winner.nil? || game_board.full?
  end

  private

  def create_player(number, symbol, color)
    print "Enter Player #{number}'s name with at least one character: "
    name = gets.chomp while name.nil? || name.empty?
    Player.new(name.capitalize.colorize(color), symbol.colorize(color))
  end

  def starter_display
    puts 'Welcome to Tic-Tac-Toe'
    puts '-------------------'
    puts 'Each player will be assigned a symbol X or O'
    puts 'A player must pick a number from 1-9 to place his symbol on the board'
    game_board.display
  end

  def swap_turn
    self.current_player = if current_player == player1
                            player2
                          else
                            player1
                          end
  end

  def randomize_first_turn
    players = [player1, player2]
    players.shuffle!
    players[0]
  end

  def final_message
    return puts "Player #{winner.name} wins!" if winner

    puts 'Game ended with a draw!'.yellow if game_board.full?
  end

  attr_reader :game_board, :player1, :player2
  attr_accessor :winner, :current_player
end
