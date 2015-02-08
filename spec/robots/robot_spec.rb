require "spec_helper"

module Robots
  describe Robot do
    subject(:robot) { described_class.new(at: start, on: board) }

    let(:board) { instance_double(Board) }
    let(:start) { Position[11, 6] }
    let(:dest) { Position[5, 8] }

    describe "movement" do
      it "moves north" do
        allow(board).to receive(:position_above) { dest }
        robot.north
        expect(robot.position).to eq dest
      end

      it "moves west" do
        allow(board).to receive(:position_left_of) { dest }
        robot.west
        expect(robot.position).to eq dest
      end

      it "moves south" do
        allow(board).to receive(:position_below) { dest }
        robot.south
        expect(robot.position).to eq dest
      end

      it "moves east" do
        allow(board).to receive(:position_right_of) { dest }
        robot.east
        expect(robot.position).to eq dest
      end
    end
  end
end
