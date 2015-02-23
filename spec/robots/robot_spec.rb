require "spec_helper"

module Robots
  describe Robot do
    subject(:robot) { Robot.new(:red, cell) }

    let(:cell) { instance_double(Cell) }
    let(:state) { instance_double(BoardState) }

    describe "movement" do
      let(:moved) { robot.moved(:any_direction, state) }

      before do
        allow(cell).to receive(:next_cell).with(:any_direction, state) { dest }
      end

      context "when the robot can move" do
        let(:dest) { instance_double(Cell) }

        it "moves as far as its cell will let it" do
          expect(moved.cell).to equal dest
        end

        it "returns a new robot instance" do
          expect(moved).not_to equal robot
        end
      end

      context "when the robot can't move" do
        let(:dest) { robot.cell }

        it "returns the same robot instance" do
          expect(moved).to be robot
        end
      end
    end

    describe "home" do
      let(:goal) { instance_double(Target) }
      before do
        allow(cell).to receive(:goal?) { true }
        allow(goal).to receive(:matches_color?) { true }
      end

      context "when the cell's target matches the goal" do
        context "when the robot's color matches the goal" do
          it "is home" do
            expect(robot).to be_home(goal)
          end
        end

        context "when the robot's color doesn't match the goal" do
          before do
            allow(goal).to receive(:matches_color?) { false }
          end

          it "is not home" do
            expect(robot).not_to be_home(goal)
          end
        end
      end

      context "when the cell's target doesn't match the goal" do
        before do
          allow(cell).to receive(:goal?) { false }
        end

        it "is not home" do
          expect(robot).not_to be_home(goal)
        end
      end
    end
  end
end
