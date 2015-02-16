require "spec_helper"

module Robots
  describe Path do
    let(:robot) { instance_double(Robot) }
    let(:moves) { %i(down right up) }
    let(:path) { Path.new(robot, moves) }
    let(:goal) { instance_double(Target) }

    before do
      allow(robot).to receive(:home?).with(goal) { true }
    end

    describe "solving" do
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

    describe "converting to outcome" do
      let(:outcome) { path.to_outcome(goal) }

      context "when solved" do
        it "returns a solved outcome" do
          expect(outcome).to be_mission_accomplished
        end

        it "includes the final robot position" do
          expect(outcome.final_state).to be robot
        end

        it "includes the moves" do
          expect(outcome.length).to eq moves.size
        end
      end

      context "when not solved" do
        before do
          allow(robot).to receive(:home?).with(goal) { false }
        end

        it "returns an unsolved outcome" do
          expect(outcome).not_to be_mission_accomplished
        end

        it "includes the final robot position" do
          expect(outcome.final_state).to be robot
        end
      end
    end

    describe "successor" do
      let(:direction) { :left }
      let(:successor) { path.successor(:left) }
      let(:next_robot) { instance_double(Robot, "next robot") }

      before do
        allow(robot).to receive(:moved).with(direction) { next_robot }
      end

      context "when the robot can move" do
        it "moves the robot" do
          expect(successor.robot).to be next_robot
        end

        it "appends the move" do
          expect(successor.moves.last).to eq direction
        end
      end

      context "when the robot can't move" do
        let(:next_robot) { robot }

        it "returns nil" do
          expect(successor).to be nil
        end
      end
    end

    describe "all successors" do
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
