require "spec_helper"

module Robots
  describe "robots at home" do
    let(:board) { Board.example }
    let(:robot) { Robot.new(robot_color, cell) }
    let(:robot_color) { :red }
    let(:goal) { Target.new(:red, :circle) }

    context "when the robot is in the goal cell" do
      context "when the goal is the same color as the robot" do
        let(:cell) { board.cell(1, 4) }

        it "is home" do
          expect(robot.home?(goal)).to be true
        end
      end

      context "when the goal is the vortex" do
        let(:cell) { board.cell(10, 8) }
        let(:goal) { Target.vortex }

        it "is home" do
          expect(robot.home?(goal)).to be true
        end
      end

      context "when the goal is a different color from the robot" do
        let(:cell) { board.cell(1, 4) }
        let(:robot_color) { :green }

        it "is home (for now - we're ignoring color)" do
          expect(robot.home?(goal)).to be true
        end
      end
    end

    context "when the robot is in a different goal cell" do
      let(:cell) { board.cell(14, 1) }

      it "is not home" do
        expect(robot.home?(goal)).to be false
      end
    end

    context "when the robot is in an empty cell" do
      let(:cell) { board.cell(0, 0) }

      it "is not home" do
        expect(robot.home?(goal)).to be false
      end
    end
  end
end
