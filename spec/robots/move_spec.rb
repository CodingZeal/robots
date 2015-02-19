require "spec_helper"

module Robots
  describe Move do
    subject(:move) { Move.new(robot, :up) }

    let(:robot) { instance_double(Robot, color: :red) }
    let(:other_robot) { instance_double(Robot, color: :green) }

    describe "successor moves" do
      context "for the last moved robot" do
        let(:moves) { move.successors(robot) }

        it "turns 90 degrees" do
          expected = %i(left right).map { |direction| Move.new(robot, direction) }
          expect(moves).to include *expected
        end

        it "doesn't continue in the same direction" do
          expect(moves).not_to include Move.new(robot, :up)
        end

        it "doesn't reverse direction" do
          expect(moves).not_to include Move.new(robot, :down)
        end
      end

      context "for other robots" do
        let(:moves) { move.successors(other_robot) }

        it "moves in every direction" do
          expected = %i(up down left right).map { |direction| Move.new(other_robot, direction) }
          expect(moves).to include *expected
        end
      end
    end
  end
end
