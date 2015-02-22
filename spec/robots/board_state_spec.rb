require "spec_helper"

module Robots
  describe BoardState do
    let(:robot1) { fake_robot(:blue) }
    let(:robot2) { fake_robot(:yellow) }
    let(:state) { BoardState.new([robot1, robot2]) }
    let(:cell) { instance_double(Cell) }

    def fake_robot(color = :silver)
      Robot.new(color, cell).tap do |robot|
        allow(robot).to receive(:home?) { false }
      end
    end

    describe "end state" do
      let(:goal) { instance_double(Target) }

      context "when one robot is home" do
        before do
          allow(robot2).to receive(:home?) { true }
        end

        specify "the game is over" do
          expect(state).to be_game_over(goal)
        end

        it "knows which robot is home" do
          expect(state.home_robot(goal)).to eq robot2
        end
      end

      context "when no robots are home" do
        specify "the game is not over" do
          expect(state).not_to be_game_over(goal)
        end

        it "knows that no robot is home" do
          expect(state.home_robot(goal)).to be_nil
        end
      end
    end

    describe "moving robots" do
      let(:moved_robot) { fake_robot }
      let(:new_state) { state.with_robot_moved(robot2, :up) }

      before do
        allow(robot2).to receive(:moved) { moved_robot }
      end

      it "creates a new state" do
        expect(new_state).not_to be state
      end

      it "replaces the original robot with its moved version" do
        expect(new_state).to eq BoardState.new([robot1, moved_robot])
      end
    end

    describe "stopping cells" do
      let(:start_cell) { instance_double(Cell, "start") }
      let(:original_stop_cell) { instance_double(Cell, "stop") }
      let(:neighbor) { instance_double(Cell, "neighbor") }
      let(:direction) { :up }
      let(:stop_cell) { state.stopping_cell(start_cell, original_stop_cell) }

      context "when one robot is between the start and stop cells" do
        before do
          allow(robot1).to receive(:between?) { false }
          allow(robot2).to receive(:between?) { true }
          allow(robot2).to receive(:neighbor_nearest) { neighbor }
        end

        it "returns the robot's neighboring cell" do
          expect(stop_cell).to equal neighbor
        end
      end

      context "when there are multiple robots between the start and stop cells" do
        let(:robot1_neighbor) { instance_double(Cell, "robot1 neighbor") }
        before do
          allow(robot1).to receive(:between?).with(start_cell, original_stop_cell) { true }
          allow(robot1).to receive(:neighbor_nearest) { robot1_neighbor }

          allow(robot2).to receive(:between?).with(start_cell, robot1_neighbor) { true }
          allow(robot2).to receive(:neighbor_nearest) { neighbor }
        end

        it "returns the nearest robot's neighboring cell" do
          expect(stop_cell).to equal neighbor
        end
      end

      context "when there is no robot between the start and stop cells" do
        before do
          allow(cell).to receive(:between?).with(start_cell, original_stop_cell) { false }
        end

        it "returns the original stopping cell" do
          expect(stop_cell).to equal original_stop_cell
        end
      end
    end

    describe "ensuring goal robot is present" do
      let(:adjusted_state) { state.dup.tap { |s| s.ensure_goal_robot_present(goal) } }

      context "when it is already present" do
        let(:goal) { Target.new(robot2.color, :circle) }

        it "makes no changes" do
          expect(adjusted_state).to eq state
        end
      end

      context "when it is not present" do
        let(:goal) { Target.new(:green, :triangle) }
        let(:replacement) { fake_robot(:green) }

        it "substitutes the correct robot" do
          expect(adjusted_state).to eq BoardState.new([replacement, robot2])
        end
      end

      context "with the vortex" do
        let(:goal) { Target.vortex }
        let(:replacement) { fake_robot(:silver) }

        it "substitutes the silver robot" do
          expect(adjusted_state).to eq BoardState.new([replacement, robot2])
        end
      end
    end

    describe "ensuring the goal robot is first" do
      let(:adjusted_state) { state.dup.tap { |s| s.ensure_goal_robot_first(goal) } }

      context "when it is already first" do
        let(:goal) { Target.new(robot1.color, :circle) }

        it "makes no changes" do
          expect(adjusted_state).to eq state
        end
      end

      context "when it is not first" do
        let(:goal) { Target.new(robot2.color, :triangle) }

        it "moves the goal robot to the beginning" do
          expect(adjusted_state).to eq BoardState.new([robot2, robot1])
        end
      end

      context "with the vortex" do
        let(:goal) { Target.vortex }

        it "makes no changes" do
          expect(adjusted_state).to eq state
        end
      end
    end
  end
end
