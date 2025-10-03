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
    board.board[@row][@column] = symbol
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
    when 1..3   # convert move for better user interaction input "1" instead of inputting "[0][0]"" 
      @row = 0
      @column = move - 1
    when 4..6
      @row = 1
      @column = move - 4
    when 7..9
      @row = 2
      @column = move - 7
    end
  end
end
