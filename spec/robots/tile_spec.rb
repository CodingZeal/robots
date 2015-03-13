require "spec_helper"

module Robots
  describe Tile do
    subject(:tile) do
      Tile.new("test", targets: targets, vertical_walls: vertical_walls, horizontal_walls: horizontal_walls)
    end

    let(:board) { instance_double(Board, size: 16) }
    let(:targets) { [[1, 4, :red, :circle]] }
    let(:vertical_walls) { [[3, 6]] }
    let(:horizontal_walls) { [[3, 6]] }
    let(:expected_target) { Target.new(:red, :circle) }

    before do
      allow(board).to receive(:add_target)
      allow(board).to receive(:add_wall_after_column)
      allow(board).to receive(:add_wall_after_row)
      tile.populate(board, quadrant: quadrant)
    end

    context "in upper left quadrant" do
      let(:quadrant) { Quadrant::UpperLeft.new }

      it "places targets directly on the board" do
        expect(board).to have_received(:add_target).with(1, 4, expected_target)
      end

      it "places vertical walls directly on the board" do
        expect(board).to have_received(:add_wall_after_column).with(3, 6)
      end

      it "places horizontal walls directly on the board" do
        expect(board).to have_received(:add_wall_after_row).with(3, 6)
      end
    end

    context "in upper right quadrant" do
      let(:quadrant) { Quadrant::UpperRight.new }

      it "rotates 90 degrees before placing targets" do
        expect(board).to have_received(:add_target).with(4, 14, expected_target)
      end

      it "rotates 90 degrees before placing vertical walls" do
        expect(board).to have_received(:add_wall_after_row).with(6, 12)
      end

      it "rotates 90 degrees before placing horizontal walls" do
        expect(board).to have_received(:add_wall_after_column).with(6, 11)
      end
    end

    context "in lower right quadrant" do
      let(:quadrant) { Quadrant::LowerRight.new }

      it "rotates 180 degrees before placing targets" do
        expect(board).to have_received(:add_target).with(14, 11, expected_target)
      end

      it "rotates 180 degrees before placing vertical walls" do
        expect(board).to have_received(:add_wall_after_column).with(12, 8)
      end

      it "rotates 180 degrees before placing horizontal walls" do
        expect(board).to have_received(:add_wall_after_row).with(11, 9)
      end
    end

    context "in lower left quadrant" do
      let(:quadrant) { Quadrant::LowerLeft.new }

      it "rotates 270 degrees before placing targets" do
        expect(board).to have_received(:add_target).with(11, 1, expected_target)
      end

      it "rotates 270 degrees before placing vertical walls" do
        expect(board).to have_received(:add_wall_after_row).with(8, 3)
      end

      it "rotates 270 degrees before placing horizontal walls" do
        expect(board).to have_received(:add_wall_after_column).with(9, 3)
      end
    end
  end
end
