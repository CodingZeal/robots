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
  end
end
