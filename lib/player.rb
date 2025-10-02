class Player
  attr_reader :name, :symbol, :moves, :valid_move, :winner
  attr_accessor :turn_over

  @@all_moves = []

  def initialize(name, symbol)
    @name = name
    @symbol = symbol
    @moves = []
    @turn_over = true
    @valid_move = nil
    @winner = nil
    @score = 0
  end

  def self.all_moves
    @@all_moves
  end

  def set_move(board, move)
    return unless analyze_move(move)

    check_winner
    board.board[@first_index][@second_index] = symbol
    board.display_board
  end

  def check_winner
    Board.winning_cords.find do |cords|
      if (cords - @moves).empty?
        @winner = true
        @score += 1
      end
    end
  end

  protected

  def analyze_move(move)
    if @@all_moves.include?(move) || !move.between?(1, 9)
      puts "Invalid move!"
      @valid_move = false
    else
      convert_move(move)
      @turn_over = true
      @valid_move = true
      @moves << move
      @@all_moves << move
    end
  end

  def convert_move(move)
    case move
    when 1
      @first_index = 0
      @second_index = 0
    when 2
      @first_index = 0
      @second_index = 1
    when 3
      @first_index = 0
      @second_index = 2
    when 4
      @first_index = 1
      @second_index = 0
    when 5
      @first_index = 1
      @second_index = 1
    when 6
      @first_index = 1
      @second_index = 2
    when 7
      @first_index = 2
      @second_index = 0
    when 8
      @first_index = 2
      @second_index = 1
    when 9
      @first_index = 2
      @second_index = 2
    end
  end
end
