require "spec_helper"

module Robots
  describe Path do
    let(:goal) { instance_double(Target) }
    let(:state) { fake_state("start state") }
    let(:intermediate_state) { fake_state("intermediate state") }
    let(:final_state) { fake_state("final state") }
    let(:initial_path) { Path.initial(state, goal) }
    let(:robot) { instance_double(Robot, color: :yellow) }
    let(:other_robot) { instance_double(Robot, color: :blue) }
    let(:path) do
      initial_path
        .successor(Move.new(robot, :up))
        .successor(Move.new(robot, :left))
    end

    def fake_state(name = "state")
      instance_double(BoardState, name, :game_over? => false, robots: [robot, other_robot])
    end

    def game_over(state)
      allow(state).to receive(:game_over?).with(goal) { true }
    end

    before do
      allow(state).to receive(:with_robot_moved) { intermediate_state }
      allow(intermediate_state).to receive(:with_robot_moved) { final_state }

      allow(final_state).to receive(:home_robot) { path.moves.last.robot }
    end

    describe "solving" do
      context "when the state is solved" do
        before do
          game_over(path.state)
        end

        context "when the goal robot has ricocheted" do
          it "is solved" do
            expect(path).to be_solved
          end
        end

        context "when the goal robot has not ricocheted" do
          let(:path) do
            initial_path
              .successor(Move.new(other_robot, :down))
              .successor(Move.new(robot, :left))
          end

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
          game_over(path.state)
        end

        it "returns a solved outcome" do
          expect(outcome).to be_mission_accomplished
        end

        it "includes the final board state" do
          expect(outcome.final_state).to be final_state
        end

        it "includes the moves" do
          expect(outcome.length).to eq 2
        end
      end

      context "when not solved" do
        it "returns an unsolved outcome" do
          expect(outcome).not_to be_mission_accomplished
        end

        it "includes the final board state" do
          expect(outcome.final_state).to be final_state
        end
      end
    end

    describe "successor" do
      let(:direction) { :left }
      let(:move) { Move.new(robot, direction) }
      let(:successor) { initial_path.successor(move) }
      let(:next_state) { fake_state("next state") }

      before do
        allow(state).to receive(:with_robot_moved).with(robot, direction) { next_state }
      end

      context "when the robot can move" do
        it "moves the robot" do
          expect(successor.state).to be next_state
        end

        it "appends the move" do
          expect(successor.moves.last).to eq move
        end

        it "visits the state" do
          expect(successor.visited).to include state
        end
      end

      context "when the robot can't move" do
        let(:next_state) { state }

        it "returns nil" do
          expect(successor).to be nil
        end
      end
    end

    describe "cycle detection" do
      context "when there is a cycle" do
        let(:final_state) { state }

        context "when starting on the goal cell" do
          before do
            game_over(state)
          end

          it "doesn't detect a cycle" do
            expect(path).not_to be_cycle
          end
        end

        context "when starting one move from the goal cell" do
          before do
            game_over(intermediate_state)
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

        it "follows all four directions for both robots" do
          expect(successors.size).to eq 8
        end
      end

      context "for later moves" do
        let(:path) do
          initial_path
            .successor(Move.new(other_robot, :left))
            .successor(Move.new(robot, :down))
        end

        before do
          allow(final_state).to receive(:with_robot_moved) { fake_state }
        end

        it "turns the last moved robot 90 degrees from its previous move" do
          included = %i(left right).map { |direction| Move.new(robot, direction) }
          excluded = %i(up down).map { |direction| Move.new(robot, direction)}
          expect(successor_moves).to include *included
          expect(successor_moves).not_to include *excluded
        end

        it "follows all four directions for other robots" do
          moves = %i(up down left right).map { |direction| Move.new(other_robot, direction) }
          expect(successor_moves).to include *moves
        end
      end

      context "when a successor move is blocked" do
        let(:path) { initial_path }

        before do
          allow(state).to receive(:with_robot_moved).with(robot, :left) { state }
        end

        it "excludes it" do
          expect(successor_moves).not_to include Move.new(robot, :left)
        end
      end

      context "when a successor contains a cycle" do
        let(:path) do
          initial_path
            .successor(Move.new(robot, :down))
            .successor(Move.new(robot, :right))
        end

        before do
          allow(final_state).to receive(:with_robot_moved) { fake_state }
          allow(final_state).to receive(:with_robot_moved).with(robot, :up) { state }
        end

        it "excludes it" do
          expect(successor_moves).not_to include Move.new(robot, :up)
        end
      end
    end
  end
end
