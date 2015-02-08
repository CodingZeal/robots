require "spec_helper"

module Robots
  describe Robot do
    subject(:robot) { Robot.new(start) }

    let(:start) { instance_double(Cell) }
    let(:dest) { instance_double(Cell) }

    describe "movement" do
      it "moves as far as its cell will let it" do
        allow(start).to receive(:next_cell).with(:any_direction) { dest }
        robot.move(:any_direction)
        expect(robot.cell).to equal dest
      end
    end
  end
end
