require "spec_helper"

module Robots
  describe "Robot movement" do
    let(:board) { Board.new }
    let(:robot) { Robot.new(at: start, on: board) }

    context "with no obstacles" do
      let(:start) { Position[5, 11] }

      it "moves up" do
        robot.move(:up)
        expect(robot.position).to eq Position[board.top, start.column]
      end

      it "moves right" do
        robot.move(:right)
        expect(robot.position).to eq Position[start.row, board.right]
      end
    end

    context "with center obstacle" do
      context "while moving down" do
        let(:start) { Position[board.top, 7] }

        it "stops at the obstacle" do
          robot.move(:down)
          expect(robot.position).to eq Position[6, start.column]
        end
      end

      context "while moving left" do
        let(:start) { Position[8, board.right] }

        it "stops at the obstacle" do
          robot.move(:left)
          expect(robot.position).to eq Position[start.row, 9]
        end
      end
    end
  end
end
