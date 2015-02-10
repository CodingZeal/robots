require "spec_helper"

module Robots
  describe Robot do
    subject(:robot) { Robot.new(:red, cell) }

    let(:cell) { instance_double(Cell) }

    describe "movement" do
      let(:dest) { instance_double(Cell) }

      it "moves as far as its cell will let it" do
        allow(cell).to receive(:next_cell).with(:any_direction) { dest }
        robot.move(:any_direction)
        expect(robot.cell).to equal dest
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
            expect(robot.home?(goal)).to be true
          end
        end

        context "when the robot's color doesn't match the goal" do
          before do
            allow(goal).to receive(:matches_color?) { false }
          end

          it "is not home" do
            expect(robot.home?(goal)).to be false
          end
        end
      end

      context "when the cell's target doesn't match the goal" do
        before do
          allow(cell).to receive(:goal?) { false }
        end

        it "is not home" do
          expect(robot.home?(goal)).to be false
        end
      end
    end
  end
end
