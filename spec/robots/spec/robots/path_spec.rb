require "spec_helper"

module Robots
  describe Path do
    let(:robot) { instance_double(Robot) }
    let(:path) { Path.new(robot, moves) }
    let(:goal) { instance_double(Target) }

    describe "solving" do
      let(:moves) { %i(down right up) }

      before do
        allow(robot).to receive(:home?).with(goal) { true }
      end

      context "when on the goal cell" do
        context "when the path is long enough" do
          it "is solved" do
            expect(path).to be_solved(goal)
          end
        end

        context "when the path is too short" do
          let(:moves) { %i(left) }

          it "is not solved" do
            expect(path).not_to be_solved(goal)
          end
        end
      end

      context "when not on the goal cell" do
        before do
          allow(robot).to receive(:home?).with(goal) { false }
        end

        it "is not solved" do
          expect(path).not_to be_solved(goal)
        end
      end
    end

    describe "successors" do
      context "for the initial move" do
        it "follows all four directions"
      end

      context "for later moves" do
        it "turns in both new directions"
      end

      context "when a successor move is blocked" do
        it "excludes it"
      end
    end

    describe "cycle detection" do
      context "when there is a cycle" do
        context "when starting on the goal cell" do
          it "doesn't detect a cycle"
        end

        context "when starting one move from the goal cell" do
          it "doesn't detect a cycle"
        end

        context "when starting away from the goal cell" do
          it "detects a cycle"
        end
      end

      context "when there is not a cycle" do
        it "doesn't detect a cycle"
      end
    end
  end
end
