require "spec_helper"

module Robots
  describe Cell do
    let(:board) { Board.new }

    describe "stopping positions" do
      context "with no obstacles" do
        let(:cell) { board.cell(5, 11) }

        it "stops at the board's edge" do
          expect(cell.next_cell(:up)).to equal board.cell(board.top, cell.column)
        end
      end

      context "with center obstacle" do
        context "when left of the obstacle" do
          let(:cell) { board.cell(7, board.left + 3) }

          it "stops at the obstacle when moving right" do
            expect(cell.next_cell(:right)).to equal board.cell(cell.row, 6)
          end

          it "stops at the board's edge when moving left" do
            expect(cell.next_cell(:left)).to equal board.cell(cell.row, board.left)
          end
        end
      end
    end

    describe "blocking movement" do
      describe "an open cell" do
        subject(:cell) { Cell.open(board, 3, 5) }

        it "is never blocked" do
          %i(up down left right).each do |direction|
            expect(cell.blocked?(direction)).to be false
          end
        end
      end

      describe "a closed cell" do
        subject(:cell) { Cell.closed(board, 8, 6) }

        it "is always blocked" do
          %i(up down left right).each do |direction|
            expect(cell.blocked?(direction)).to be true
          end
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
