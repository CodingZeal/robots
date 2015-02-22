require "spec_helper"

module Robots
  describe Board do
    subject(:board) { Board.new }

    describe "stopping cells" do
      let(:stopping_cell) { board.stopping_cell(cell, direction) }

      context "in the open" do
        let(:cell) { board.cell(10, 3) }

        context "moving left" do
          let(:direction) { :left }

          it "stops at the left edge" do
            expect(stopping_cell).to eq board.cell(cell.row, board.left)
          end
        end

        context "moving down" do
          let(:direction) { :down }

          it "stops at the bottom edge" do
            expect(stopping_cell).to eq board.cell(board.bottom, cell.column)
          end
        end
      end

      context "near a wall" do
        let(:cell) { board.cell(10, 0) }
        let(:direction) { :up }

        before do
          board.add_wall_after_row(5, 0)
        end

        it "stops at the wall" do
          expect(stopping_cell).to eq board.cell(6, cell.column)
        end
      end

      context "near the island" do
        let(:cell) { board.cell(7, 3) }
        let(:direction) { :right }

        it "stops at the island" do
          expect(stopping_cell).to eq board.cell(cell.row, 6)
        end
      end
    end

    describe "random cells" do
      let(:random) { instance_double(Random) }

      before do
        allow(random).to receive(:rand).and_return(*random_values)
      end

      context "when no island cells are generated" do
        let(:random_values) { [13, 4] }

        it "returns the first generated cell" do
          expect(board.random_cell(random)).to equal board.cell(13, 4)
        end
      end

      context "when island cells are generated" do
        let(:random_values) { [7, 8, 8, 7, 2, 15] }

        it "generates new cells until a non-island cell is found" do
          expect(board.random_cell(random)).to equal board.cell(2, 15)
        end
      end
    end

    describe "targets" do
      let(:targets) { [Target.new(:red, :circle), Target.vortex] }

      before do
        board.cell(2, 3).target = targets.first
        board.cell(11, 8).target = targets.last
      end

      it "knows all of its targets" do
        expect(board.targets).to match_array targets
      end
    end
  end
end
