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
