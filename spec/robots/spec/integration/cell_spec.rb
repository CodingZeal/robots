require "spec_helper"

module Robots
  describe Cell do
    let(:board) { Board.new }

    describe "enumeration" do
      let(:cell) { Cell.open(board, 3, 5) }

      it "yields each cell above itself" do
        enum = cell.each_moving(:up)
        2.times { enum.next }
        expect(enum.next).to equal board.cell(cell.row - 3, cell.column)
      end

      it "yields each cell below itself" do
        enum = cell.each_moving(:down)
        2.times { enum.next }
        expect(enum.next).to equal board.cell(cell.row + 3, cell.column)
      end

      it "yields each cell left of itself" do
        enum = cell.each_moving(:left)
        2.times { enum.next }
        expect(enum.next).to equal board.cell(cell.row, cell.column - 3)
      end

      it "yields each cell right of itself" do
        enum = cell.each_moving(:right)
        2.times { enum.next }
        expect(enum.next).to equal board.cell(cell.row, cell.column + 3)
      end

      it "yields nil past the edge of the board" do
        enum = cell.each_moving(:up)
        cell.row.times { enum.next }
        expect(enum.next).to be_nil
      end
    end

    describe "blocking movement" do
      describe "an open cell" do
        subject(:cell) { Cell.open(board, 3, 5) }

        it "is never blocked" do
          expect(cell.blocked?(:any_direction)).to be false
        end
      end

      describe "a closed cell" do
        subject(:cell) { Cell.closed(board, 8, 6) }

        it "is always blocked" do
          expect(cell.blocked?(:any_direction)).to be true
        end
      end

      describe "a cell with a bottom wall" do
        subject(:cell) do
          Cell.open(board, 4, 10).tap do |cell|
            cell.block(:up)
          end
        end

        it "is blocked from below" do
          expect(cell.blocked?(:up)).to be true
        end

        it "isn't blocked from above" do
          expect(cell.blocked?(:down)).to be false
        end
      end
    end
  end
end
