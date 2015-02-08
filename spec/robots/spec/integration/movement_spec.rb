require "spec_helper"

module Robots
  describe "Robot movement" do
    let(:board) { Board.new }
    let(:robot) { Robot.new(at: start, on: board) }

    context "with no obstacles" do
      let(:start) { Position[5, 11] }

      it "moves north" do
        robot.north
        expect(robot.position).to eq Position[board.top, start.column]
      end

      it "moves east" do
        robot.east
        expect(robot.position).to eq Position[start.row, board.right]
      end
    end

    context "with center obstacle" do
      context "while moving south" do
        let(:start) { Position[board.top, 7] }

        it "stops at the obstacle" do
          robot.south
          expect(robot.position).to eq Position[6, start.column]
        end
      end

      context "while moving west" do
        let(:start) { Position[8, board.right] }

        pending "stops at the obstacle" do
          robot.west
          expect(robot.position).to eq Position[start.row, 9]
        end
      end
    end
  end
end
