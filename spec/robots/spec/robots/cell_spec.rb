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

      context "when at the board edge" do
        let(:cell) { board.cell(15, 4) }

        it "stays in place" do
          expect(cell.next_cell(:down)).to eq cell
        end
      end

      context "when against the obstacle" do
        let(:cell) { board.cell(7, 9) }

        it "stays in place" do
          expect(cell.next_cell(:left)).to eq cell
        end
      end
    end
  end
end
