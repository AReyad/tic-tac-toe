class Player
  attr_reader :name, :symbol, :moves
  attr_accessor :turn_over

  def initialize(name, symbol)
    @name = name
    @symbol = symbol
    @moves = []
    @turn_over = true
    @score = 0
  end

  def set_move(board, move)
    return unless Board.analyze_move(self, move)

    board.board[move - 1] = symbol
    board.display
  end
end
