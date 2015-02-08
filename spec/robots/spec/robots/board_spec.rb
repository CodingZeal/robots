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
        let(:start) { Position[5, 11] }

        it "stops at the board's edge" do
          expect(board.next_position(start, :up)).to eq Position[board.top, start.column]
        end
      end

      context "with center obstacle" do
        context "when left of the obstacle" do
          let(:start) { Position[7, board.left + 3] }

          it "stops at the obstacle when moving right" do
            expect(board.next_position(start, :right)).to eq Position[start.row, 6]
          end

          it "stops at the board's edge when moving left" do
            expect(board.next_position(start, :left)).to eq Position[start.row, board.left]
          end
        end
      end
    end
  end
end
