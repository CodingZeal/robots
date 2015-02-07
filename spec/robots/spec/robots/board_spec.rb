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

    describe "stopping positions" do
      context "with no obstacles" do
        let(:start) { Position.new(row: 5, column: 11) }

        it "stops at top edge" do
          expect(board.position_above(start)).to eq Position.new(row: board.top, column: start.column)
        end

        it "stops at bottom edge" do
          expect(board.position_below(start)).to eq Position.new(row: board.bottom, column: start.column)
        end

        it "stops at left edge" do
          expect(board.position_left_of(start)).to eq Position.new(row: start.row, column: board.left)
        end

        it "stops at right edge" do
          expect(board.position_right_of(start)).to eq Position.new(row: start.row, column: board.right)
        end
      end

      context "with center obstacle" do
        context "when below the obstacle" do
          let(:start) { Position.new(row: board.bottom - 3, column: 7) }

          it "stops at the obstacle when moving north" do
            expect(board.position_above(start)).to eq Position.new(row: 9, column: start.column)
          end

          it "stops at the bottom when moving south" do
            expect(board.position_below(start)).to eq Position.new(row: board.bottom, column: start.column)
          end
        end

        context "when above the obstacle" do
          let(:start) { Position.new(row: board.top + 2, column: 8) }

          it "stops at the top when moving north" do
            expect(board.position_above(start)).to eq Position.new(row: board.top, column: start.column)
          end

          it "stops at the obstacle when moving south" do
            expect(board.position_below(start)).to eq Position.new(row: 6, column: start.column)
          end
        end
      end
    end
  end
end
