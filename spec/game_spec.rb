require_relative '../lib/game'

# List of methods to be tested -V-
# play <- looping script, and sends msgs to other methods
# make_move <- command
# create_player_one && create_player_two <- Query
# winner? <- query && command
# check_and_assign_winner <- command

describe Game do
  # Change instance double to double

  let(:cords) do
    [[0, 1, 2], [3, 4, 5], [6, 7, 8],
     [0, 3, 6], [1, 4, 7], [2, 5, 8],
     [0, 4, 8], [2, 4, 6]]
  end

  describe '#game_over' do
    let(:board) { instance_double(Board) }
    let(:player1) { instance_double(Player) }
    let(:player2) { instance_double(Player) }

    context 'when board is not full' do
      subject(:not_full_board_game) { described_class.new(player1, player2, board) }

      before do
        allow(board).to receive(:full?).and_return false
      end
      it 'is not game over' do
        expect(not_full_board_game).to_not be_game_over
      end
    end

    context 'when board is full' do
      subject(:full_board_game) { described_class.new(player1, player2, board) }

      before do
        allow(board).to receive(:full?).and_return true
      end
      it 'is game over' do
        expect(full_board_game).to be_game_over
      end
    end

    context 'when there is a winner' do
      subject(:winner_game) { described_class.new(player1, player2, board) }

      it 'is game over' do
        winner_game.instance_variable_set(:@winner, player1)
        expect(winner_game).to be_game_over
      end
    end

    context 'when there is no winner' do
      subject(:no_winner_game) { described_class.new(player1, player2, board) }

      before do
        allow(board).to receive(:full?).and_return false
      end
      it 'is not game over' do
        expect(no_winner_game).to_not be_game_over
      end
    end
  end

  describe '#winner?' do
    let(:player1) { instance_double(Player) }
    let(:player2) { instance_double(Player) }
    let(:winner_board) { instance_double(Board) }

    before do
      allow(winner_board).to receive(:winning_cords).and_return cords
    end

    context 'when a player has 3 moves in the same row' do
      subject(:row_winner_game) { described_class.new(player1, player2, winner_board) }
      before do
        allow(winner_board).to receive(:board).and_return %w[x x x 4 5 6 7 8 9]
        allow(player1).to receive(:symbol).and_return 'x'
        allow(player2).to receive(:symbol).and_return 'o'
      end

      it 'returns true for the winner player' do
        result = row_winner_game.winner?(player1)
        expect(result).to be true
      end

      it 'returns false for the other player' do
        result = row_winner_game.winner?(player2)
        expect(result).to be false
      end
    end

    context 'when a player has 3 moves diagonally' do
      subject(:diagonal_winner_game) { described_class.new(player1, player2, winner_board) }

      before do
        allow(winner_board).to receive(:board).and_return %w[o 2 3 4 o 6 7 8 o]
        allow(player1).to receive(:symbol).and_return 'x'
        allow(player2).to receive(:symbol).and_return 'o'
      end

      it 'returns true for the winner player' do
        winner_result = diagonal_winner_game.winner?(player2)
        expect(winner_result).to be true
      end
      it 'returns false for the other player' do
        winner_result = diagonal_winner_game.winner?(player1)
        expect(winner_result).to be false
      end
    end

    context 'when a player has 3 moves in the same column' do
      subject(:column_winner_game) { described_class.new(player1, player2, winner_board) }

      before do
        allow(winner_board).to receive(:board).and_return %w[o 2 3 o 5 6 o 8 9]
        allow(player2).to receive(:symbol).and_return 'o'
        allow(player1).to receive(:symbol).and_return 'x'
      end

      it 'returns true for the winner player' do
        winner_result = column_winner_game.winner?(player2)
        expect(winner_result).to be true
      end

      it 'returns false for the other player' do
        winner_result = column_winner_game.winner?(player1)
        expect(winner_result).to be false
      end
    end

    context 'when no player has 3 winning moves' do
      let(:no_winner_board) { instance_double(Board) }
      subject(:no_winner_game) { described_class.new(player1, player2, no_winner_board) }

      before do
        allow(no_winner_board).to receive(:winning_cords).and_return cords
        allow(no_winner_board).to receive(:board).and_return %w[o x 3 x 5 6 o 8 9]
        allow(player1).to receive(:symbol).and_return 'x'
        allow(player2).to receive(:symbol).and_return 'o'
      end

      it 'returns false for both players' do
        winner_result_player1 = no_winner_game.winner?(player1)
        winner_result_player2 = no_winner_game.winner?(player2)
        expect(winner_result_player1).to be false
        expect(winner_result_player2).to be false
      end
    end
  end

  describe '#make_move' do
    let(:move_board) { instance_double(Board) }
    let(:player1) { instance_double(Player) }
    let(:player2) { instance_double(Player) }
    subject(:move_game) { described_class.new(player1, player2, move_board) }

    before do
      allow(move_board).to receive(:assign_move)
      allow(move_board).to receive(:display)
    end

    it 'sends assign_move to board' do
      player_move = 3
      expect(move_board).to receive(:assign_move).once
      move_game.make_move(player_move)
    end

    it 'sends display to board' do
      player_move = 7
      expect(move_board).to receive(:display).once
      move_game.make_move(player_move)
    end
  end

  describe '#check_and_assign_winner' do
    let(:check_board) { instance_double(Board) }
    let(:player1) { instance_double(Player) }
    let(:player2) { instance_double(Player) }
    subject(:check_winner_game) { described_class.new(player1, player2, check_board) }

    context 'when no winner' do
      before do
        allow(check_winner_game).to receive(:winner?).with(player1).and_return false
        allow(check_winner_game).to receive(:winner?).with(player2).and_return false
      end

      it 'does not assign a winner' do
        expect { check_winner_game.check_and_assign_winner(player1) }.to_not(change do
          check_winner_game.instance_variable_get(:@winner)
        end)
      end
    end

    context 'when player1 is winner' do
      before do
        allow(check_winner_game).to receive(:winner?).with(player1).and_return true
      end

      it 'assigns winner to player1' do
        expect { check_winner_game.check_and_assign_winner(player1) }.to change {
          check_winner_game.instance_variable_get(:@winner)
        }.to player1
      end
    end

    context 'when player2 is winner' do
      before do
        allow(check_winner_game).to receive(:winner?).with(player2).and_return true
      end

      it 'assigns winner to player2' do
        expect { check_winner_game.check_and_assign_winner(player2) }.to change {
          check_winner_game.instance_variable_get(:@winner)
        }.to player2
      end
    end
  end
end
