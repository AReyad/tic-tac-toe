require_relative '../lib/game'

describe Board do
  describe '#full?' do
    context 'when board has all cells occupied' do
      subject(:full_board) { described_class.new(%w[x x y y x y x y y]) }
      it 'is full' do
        expect(full_board).to be_full
      end
    end

    context 'when board has one cell that is empty' do
      subject(:one_empty_cell_board) { described_class.new(['x', 'x', 'y', 'y', 'x', 'y', 'x', 'y', nil]) }
      it 'is not full' do
        expect(one_empty_cell_board).to_not be_full
      end
    end

    context 'when board has all cells empty' do
      subject(:empty_board) { described_class.new([nil, nil, nil, nil, nil, nil, nil, nil, nil]) }
      it 'is not full' do
        expect(empty_board).to_not be_full
      end
    end
  end

  describe '#valid_move?' do
    context 'when move is between 1 and 9' do
      subject(:within_range_move_board) { described_class.new([nil, nil, nil, nil, nil, nil, nil, nil, nil]) }
      it 'is valid move' do
        valid_move = 4
        result = within_range_move_board.valid_move?(valid_move)
        expect(result).to be true
      end
    end

    context 'when move is not between 1 and 9' do
      subject(:out_range_move_board) { described_class.new([nil, nil, nil, nil, nil, nil, nil, nil, nil]) }
      it 'is invalid move' do
        invalid_move = 10
        result = out_range_move_board.valid_move?(invalid_move)
        expect(result).to be false
      end
    end

    context 'when cell is empty' do
      subject(:empty_cell_board) { described_class.new([nil, nil, nil, nil, 'x', nil, nil, nil, nil]) }

      it 'is valid move' do
        valid_move = 4
        result = empty_cell_board.valid_move?(valid_move)
        expect(result).to be true
      end
    end

    context 'when cell is occupied' do
      subject(:occupied_cell_board) { described_class.new([nil, nil, nil, nil, 'x', nil, nil, nil, nil]) }

      it 'is invalid move' do
        invalid_move = 5
        result = occupied_cell_board.valid_move?(invalid_move)
        expect(result).to be false
      end
    end
  end
end
