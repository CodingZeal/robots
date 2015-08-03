require "spec_helper"

module Robots
  describe Path do
    let(:path) { Path.new(state, moves) }
    let(:state) { fake_state("state") }
    let(:moves) { [Move.new(robot, :up), Move.new(robot, :left)] }
    let(:robot) { instance_double(Robot, color: :yellow) }
    let(:other_robot) { instance_double(Robot, color: :blue) }

    def fake_state(name = "state")
      instance_double(BoardState, name, :game_over? => false, robots: [robot, other_robot])
    end

    def game_over(state)
      allow(state).to receive(:game_over?) { true }
    end

    before do
      allow(state).to receive(:home_robot) { moves.last.robot }
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
          let(:moves) { [Move.new(other_robot, :down), Move.new(robot, :left)] }

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
          expect(outcome.final_state).to be state
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
          expect(outcome.final_state).to be state
        end
      end
    end

    describe "successor" do
      let(:path) { Path.initial(state) }
      let(:direction) { :left }
      let(:move) { Move.new(robot, direction) }
      let(:successor) { path.successor(move) }
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
      end

      context "when the robot can't move" do
        let(:next_state) { state }

        it "returns nil" do
          expect(successor).to be nil
        end
      end
    end

    describe "allowable successors" do
      let(:successors) { path.allowable_successors }
      let(:successor_moves) { successors.map { |succ| succ.moves.last } }

      before do
        allow(state).to receive(:with_robot_moved) { fake_state }
      end

      context "for the initial move" do
        let(:path) { Path.initial(state) }

        it "follows all four directions for both robots" do
          expect(successors.size).to eq 8
        end
      end

      context "for later moves" do
        let(:moves) { [Move.new(other_robot, :left), Move.new(robot, :down)] }

        before do
          allow(state).to receive(:with_robot_moved) { fake_state }
        end

        it "turns the last moved robot 90 degrees from its previous move" do
          included = %i(left right).map { |direction| Move.new(robot, direction) }
          excluded = %i(up down).map { |direction| Move.new(robot, direction) }
          expect(successor_moves).to include(*included)
          expect(successor_moves).not_to include(*excluded)
        end

        it "follows all four directions for other robots" do
          moves = %i(up down left right).map { |direction| Move.new(other_robot, direction) }
          expect(successor_moves).to include(*moves)
        end
      end

      context "when a successor move is blocked" do
        let(:path) { Path.initial(state) }

        before do
          allow(state).to receive(:with_robot_moved).with(robot, :left) { state }
        end

        it "excludes it" do
          expect(successor_moves).not_to include Move.new(robot, :left)
        end
      end
    end
  end
end
