require "spec_helper"

module Robots
  describe Board do
    subject(:board) { Board.new }

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
