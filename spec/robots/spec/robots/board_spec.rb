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
