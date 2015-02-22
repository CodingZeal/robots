require "spec_helper"

module Robots
  describe Grid do
    subject(:grid) do
      Grid.new(grid_size) do |row, column|
        [row, column]
      end
    end

    let(:grid_size) { 8 }

    describe "boundaries" do
      it "uses 0-based indexing" do
        expect(grid.top).to eq 0
        expect(grid.left).to eq 0
      end

      it "is a square of the given size" do
        expect(grid.bottom).to eq grid_size - 1
        expect(grid.right).to eq grid_size - 1
      end
    end

    describe "element access" do
      it "accesses elements within its boundaries" do
        expect(grid.at(5, 1)).to eq [5, 1]
      end

      it "returns nil for cells outside the boundaries" do
        expect(grid.at(grid.top - 1, 3)).to be_nil
        expect(grid.at(5, grid.right + 1)).to be_nil
      end
    end

    describe "random elements" do
      let(:random) { instance_double(Random) }

      before do
        allow(random).to receive(:rand).and_return(6, 4)
      end


      it "returns a random element" do
        expect(grid.random_element(random)).to equal grid.at(6, 4)
      end
    end

    describe "enumeration" do
      it "enumerates all of the elements" do
        expect(grid.each_element.to_a).to include [3, 4]
      end
    end
  end
end
