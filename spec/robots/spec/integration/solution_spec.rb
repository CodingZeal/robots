require "spec_helper"

module Robots
  describe "Solutions" do
    let(:board) { Board.example }
    let(:solver) { Solvers::RecursiveDfs.new(robot, goal) }
    let(:outcome) { solver.outcome }

    context "with a single robot" do
      let(:robot) { Robot.new(:green, start) }

      context "when there are solutions" do
        let(:goal) { Target.new(:green, :circle) }
        let(:start) { board.cell(6, 14) }

        it "finds a solution" do
          expect(outcome).to be_mission_accomplished
        end

        it "finds the shortest solution" do
          expect(outcome.length).to eq 4
        end

        it "remembers the final robot position" do
          expect(outcome.final_state).to eq Robot.new(:green, board.cell(9, 2))
        end

        context "when there is a one-move solution" do
          let(:start) { board.cell(9, 12) }

          it "finds a longer solution" do
            expect(outcome.length).to be > 1
          end
        end
      end

      context "when there are no solutions" do
        let(:goal) { Target.new(:green, :triangle) }
        let(:start) { board.cell(0, 0) }

        it "finishes without a solution" do
          expect(outcome).not_to be_mission_accomplished
        end

        it "leaves the robot in its starting position" do
          expect(outcome.final_state).to eq robot
        end
      end
    end
  end
end
