require_relative "lib/board"
require_relative "lib/player"

def play_game
  puts "Welcome to Tic-Tac-Toe"
  puts "-------------------"
  display_guide
  game_board = Board.new
  print "Enter Player 1's name: "
  player1 = Player.new(gets.chomp.capitalize, "x")
  print "Enter Player 2's name: "
  player2 = Player.new(gets.chomp.capitalize, "o")
  swap_turn(player1, player2, game_board) until Board.game_over(player1, player2)
end

def swap_turn(player1, player2, board)
  if player2.turn_over
    puts "#{player1.name}'s turn pick your position:"
    player1.set_move(board, gets.chomp.to_i)
    validate_move(player2, player1)
  elsif player1.turn_over
    puts "#{player2.name}'s turn pick your position:"
    player2.set_move(board, gets.chomp.to_i)
    validate_move(player1, player2)
  end
end

def validate_move(other_player, current_player)
  other_player.turn_over = false if current_player.valid_move == true
end

def display_guide
  puts "Each player will be assigned one symbol X or O"
  puts "The board consists of 9 tiles"
  puts "Each tile represnts a number from 1-9"
  puts "A player must pick a number to place his symbol"
  puts "The board:"
  Board.new.display_board
end
play_game
