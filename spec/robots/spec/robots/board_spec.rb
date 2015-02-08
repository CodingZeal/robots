require "spec_helper"

module Robots
  describe Board do
    subject(:board) { Board.new }

    describe "boundaries" do
      it "uses 0-based indexing" do
        expect(board.top).to eq 0
        expect(board.left).to eq 0
      end

      it "is a 16x16 square" do
        expect(board.bottom).to eq 15
        expect(board.right).to eq 15
      end
    end

    describe "cell access" do
      it "accesses cells within its boundaries" do
        expect(board.cell(5, 11).row).to eq 5
      end

      it "returns nil for cells outside the boundaries" do
        expect(board.cell(board.top - 1, 10)).to be_nil
        expect(board.cell(5, board.right + 1)).to be_nil
      end
    end

    describe "stopping positions" do
      context "with no obstacles" do
        let(:start) { board.cell(5, 11) }

        it "stops at the board's edge" do
          expect(board.next_cell(start, :up)).to equal board.cell(board.top, start.column)
        end
      end

      context "with center obstacle" do
        context "when left of the obstacle" do
          let(:start) { board.cell(7, board.left + 3) }

          it "stops at the obstacle when moving right" do
            expect(board.next_cell(start, :right)).to equal board.cell(start.row, 6)
          end

          it "stops at the board's edge when moving left" do
            expect(board.next_cell(start, :left)).to equal board.cell(start.row, board.left)
          end
        end
      end
    end
  end
end
