require "spec_helper"

module Robots
  describe Cell do
    let(:board) { Board.new }
    let(:state) { instance_double(BoardState) }

    before do
      allow(state).to receive(:blocked?) { false }
    end

    def next_cell(direction)
      cell.next_cell(direction, state)
    end

    def place_robot_at(row, column)
      allow(state).to receive(:blocked?).with(board.cell(row, column)) { true }
    end

    describe "stopping positions" do
      context "with no obstacles" do
        let(:cell) { board.cell(5, 11) }

        it "stops at the board's edge" do
          expect(next_cell(:up)).to equal board.cell(board.top, cell.column)
        end
      end

      context "with center obstacle" do
        context "when left of the obstacle" do
          let(:cell) { board.cell(7, board.left + 3) }

          it "stops at the obstacle when moving right" do
            expect(next_cell(:right)).to equal board.cell(cell.row, 6)
          end

          it "stops at the board's edge when moving left" do
            expect(next_cell(:left)).to equal board.cell(cell.row, board.left)
          end
        end
      end

      context "when at the board edge" do
        let(:cell) { board.cell(15, 4) }

        it "stays in place" do
          expect(next_cell(:down)).to eq cell
        end
      end

      context "when against the obstacle" do
        let(:cell) { board.cell(7, 9) }

        it "stays in place" do
          expect(next_cell(:left)).to eq cell
        end
      end

      context "with a robot in the way" do
        let(:cell) { board.cell(0, 0) }

        before do
          place_robot_at(0, 4)
        end

        it "stops next to the robot" do
          expect(next_cell(:right)).to eq board.cell(0, 3)
        end
      end
    end
  end
end
