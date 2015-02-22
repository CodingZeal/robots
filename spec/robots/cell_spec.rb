require "spec_helper"

module Robots
  describe Cell do
    let(:board) { Board.new }
    let(:state) { instance_double(BoardState) }

    describe "stopping positions" do
      before do
        allow(state).to receive(:stopping_cell) { |_, stop| stop }
      end

      def next_cell(direction)
        cell.next_cell(direction, state)
      end

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
          allow(state).to receive(:stopping_cell) { board.cell(0, 3) }
        end

        it "stops next to the robot" do
          expect(next_cell(:right)).to eq board.cell(0, 3)
        end
      end
    end

    describe "#between?" do
      let(:cell) { board.cell(3, 5) }
      let(:between) { cell.between?(first, last) && cell.between?(last, first) }

      context "when in the same row" do
        let(:first) { board.cell(cell.row, cell.column - 1) }
        let(:last) { board.cell(cell.row, cell.column + 1) }

        context "when in the middle" do
          it "returns true" do
            expect(between).to be true
          end
        end

        context "when before first" do
          let(:first) { last }

          it "returns false" do
            expect(between).to be false
          end
        end

        context "when after last" do
          let(:last) { first }

          it "returns false" do
            expect(between).to be false
          end
        end
      end

      context "when in the same column" do
        let(:first) { board.cell(cell.row - 1, cell.column) }
        let(:last) { board.cell(cell.row + 1, cell.column) }

        context "when in the middle" do
          it "returns true" do
            expect(between).to be true
          end
        end

        context "when before first" do
          let(:first) { last }

          it "returns false" do
            expect(between).to be false
          end
        end

        context "when after last" do
          let(:last) { first }

          it "returns false" do
            expect(between).to be false
          end
        end
      end

      context "when in different row and column" do
        let(:first) { board.cell(cell.row - 1, cell.column + 1) }
        let(:last) { board.cell(cell.row + 1, cell.column - 1) }

        it "returns false" do
          expect(between).to be false
        end
      end
    end

    describe "nearest neighbor" do
      let(:cell) { board.cell(3, 5) }
      let(:neighbor) { cell.neighbor_nearest(other) }

      context "to the left" do
        let(:other) { board.cell(cell.row, board.left) }

        it "finds the left neighbor" do
          expect(neighbor).to eq cell.left
        end
      end

      context "to the right" do
        let(:other) { board.cell(cell.row, board.right) }

        it "finds the right neighbor" do
          expect(neighbor).to eq cell.right
        end
      end

      context "above" do
        let(:other) { board.cell(board.top, cell.column) }

        it "finds the neighbor above" do
          expect(neighbor).to eq cell.up
        end
      end

      context "below" do
        let(:other) { board.cell(board.bottom, cell.column) }

        it "finds the neighbor below" do
          expect(neighbor).to eq cell.down
        end
      end

      context "to itself" do
        let(:other) { cell }

        it "returns nil" do
          expect(neighbor).to be_nil
        end
      end

      context "in other row and column" do
        let(:other) { board.cell(cell.row + 1, cell.column - 1) }

        it "returns nil" do
          expect(neighbor).to be_nil
        end
      end
    end
  end
end
