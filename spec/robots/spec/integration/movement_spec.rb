require "spec_helper"

module Robots
  describe "Robot movement" do
    let(:board) { Board.new }
    let(:robot) { Robot.new(at: start, on: board) }

    context "with no obstacles" do
      let(:start) { Position.new(row: 5, column: 11) }

      it "moves north" do
        robot.north
        expect(robot.position).to eq Position.new(row: board.top, column: start.column)
      end

      it "moves east" do
        robot.east
        expect(robot.position).to eq Position.new(row: start.row, column: board.right)
      end
    end

    context "with center obstacle" do
      context "while moving south" do
        let(:start) { Position.new(row: board.top, column: 7) }

        it "stops at the obstacle" do
          robot.south
          expect(robot.position).to eq Position.new(row: 6, column: start.column)
        end
      end

      context "while moving west" do
        let(:start) { Position.new(row: 8, column: board.right) }

        pending "stops at the obstacle" do
          robot.west
          expect(robot.position).to eq Position.new(row: start.row, column: 9)
        end
      end
    end
  end
end
