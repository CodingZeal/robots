require "spec_helper"

module Robots
  describe BoardState do
    let(:robot1) { fake_robot("robot1") }
    let(:robot2) { fake_robot("robot2") }
    let(:state) { BoardState.new([robot1, robot2]) }
    let(:cell) { instance_double(Cell) }

    def fake_robot(name = "robot")
      instance_double(Robot, name, :home? => false, cell: cell)
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

    describe "blocking" do
      let(:other_cell) { instance_double(Cell) }

      context "when a robot is in a cell" do
        before do
          allow(robot1).to receive(:cell) { other_cell }
        end

        it "blocks the cell" do
          expect(state).to be_blocked(other_cell)
        end
      end

      context "when a robot is not in the cell" do
        it "doesn't block the cell" do
          expect(state).not_to be_blocked(other_cell)
        end
      end
    end
  end
end
