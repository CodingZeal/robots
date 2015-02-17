require "spec_helper"

module Robots
  describe BoardState do
    let(:robot1) { fake_robot("robot1") }
    let(:robot2) { fake_robot("robot2") }
    let(:state) { BoardState.new([robot1, robot2]) }

    def fake_robot(name = "robot")
      instance_double(Robot, name, :home? => false)
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
      end

      context "when no robots are home" do
        specify "the game is not over" do
          expect(state).not_to be_game_over(goal)
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
  end
end
