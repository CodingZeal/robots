require "spec_helper"

module Robots
  describe Robot do
    subject(:robot) { described_class.new(at: start, on: board) }

    let(:board) { instance_double(Board) }
    let(:start) { Position[11, 6] }
    let(:dest) { Position[5, 8] }

    describe "movement" do
      it "moves as far as the board will let it" do
        allow(board).to receive(:next_position).with(start, :any_direction) { dest }
        robot.move(:any_direction)
        expect(robot.position).to eq dest
      end
    end
  end
end
