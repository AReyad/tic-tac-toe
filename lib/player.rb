class Player
  attr_reader :name, :symbol, :moves
  attr_accessor :turn_over

  def initialize(name, symbol)
    @name = name
    @symbol = symbol
  end

  def move
    gets.chomp.to_i
  end
end
