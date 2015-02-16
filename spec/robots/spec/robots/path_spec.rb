require "spec_helper"

module Robots
  describe Path do
    let(:robot) { fake_robot("initial robot") }
    let(:intermediate_robot) { fake_robot("intermediate robot") }
    let(:final_robot) { fake_robot("final robot") }
    let(:goal) { instance_double(Target) }
    let(:initial_path) { Path.initial(robot, goal) }
    let(:path) { initial_path.successor(:up).successor(:left) }

    def fake_robot(name = "robot")
      instance_double(Robot, name, :home? => false)
    end

    def robot_is_home(robot)
      allow(robot).to receive(:home?).with(goal) { true }
    end

    before do
      allow(robot).to receive(:moved) { intermediate_robot }
      allow(intermediate_robot).to receive(:moved) { final_robot }
    end

    describe "solving" do
      context "when on the goal cell" do
        before do
          robot_is_home(path.robot)
        end

        context "when the path is long enough" do
          it "is solved" do
            expect(path).to be_solved
          end
        end

        context "when the path is too short" do
          let(:path) { initial_path.successor(:down) }

          it "is not solved" do
            expect(path).not_to be_solved
          end
        end
      end

      context "when not on the goal cell" do
        it "is not solved" do
          expect(path).not_to be_solved
        end
      end
    end

    describe "converting to outcome" do
      let(:outcome) { path.to_outcome }

      context "when solved" do
        before do
          robot_is_home(path.robot)
        end

        it "returns a solved outcome" do
          expect(outcome).to be_mission_accomplished
        end

        it "includes the final robot position" do
          expect(outcome.final_state).to be final_robot
        end

        it "includes the moves" do
          expect(outcome.length).to eq 2
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
          expect(outcome.final_state).to be final_robot
        end
      end
    end

    describe "successor" do
      let(:direction) { :left }
      let(:successor) { initial_path.successor(direction) }
      let(:next_robot) { fake_robot("next robot") }

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

        it "visits the robot" do
          expect(successor.visited).to include robot
        end
      end

      context "when the robot can't move" do
        let(:next_robot) { robot }

        it "returns nil" do
          expect(successor).to be nil
        end
      end
    end

    describe "cycle detection" do
      context "when there is a cycle" do
        let(:final_robot) { robot }

        context "when starting on the goal cell" do
          before do
            robot_is_home(robot)
          end

          it "doesn't detect a cycle" do
            expect(path).not_to be_cycle
          end
        end

        context "when starting one move from the goal cell" do
          before do
            robot_is_home(intermediate_robot)
          end

          it "doesn't detect a cycle" do
            expect(path).not_to be_cycle
          end
        end

        context "when starting away from the goal cell" do
          it "detects a cycle" do
            expect(path).to be_cycle
          end
        end
      end

      context "when there is not a cycle" do
        it "doesn't detect a cycle" do
          expect(path).not_to be_cycle
        end
      end
    end

    describe "allowable successors" do
      let(:successors) { path.allowable_successors }
      let(:successor_moves) { successors.map { |succ| succ.moves.last } }

      context "for the initial move" do
        let(:path) { initial_path }

        it "follows all four directions" do
          expect(successors.size).to eq 4
        end
      end

      context "for later moves" do
        let(:path) { initial_path.successor(:left).successor(:down) }

        before do
          allow(final_robot).to receive(:moved) { fake_robot }
        end

        it "turns 90 degrees from last move" do
          expect(successor_moves).to eq %i(left right)
        end
      end

      context "when a successor move is blocked" do
        let(:path) { initial_path }

        before do
          allow(robot).to receive(:moved).with(:left) { robot }
        end

        it "excludes it" do
          expect(successor_moves).not_to include :left
        end
      end

      context "when a successor contains a cycle" do
        let(:path) { initial_path.successor(:down).successor(:right) }

        before do
          allow(final_robot).to receive(:moved).with(:up) { robot }
          allow(final_robot).to receive(:moved).with(:down) { fake_robot }
        end

        it "excludes it" do
          expect(successor_moves).not_to include :up
        end
      end
    end
  end
end
