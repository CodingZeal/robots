require "spec_helper"

module Robots
  describe "Solutions" do
    let(:board) { Board.new }
    let(:solver) { Solvers::RecursiveDfs.new(robot, goal) }

    before do
      BoardMaker.new(board).populate_example
    end

    context "with a single robot" do
      let(:robot) { Robot.new(:green, start) }

      context "when there are solutions" do
        let(:goal) { Target.new(:green, :circle) }
        let(:start) { board.cell(6, 14) }

        it "finds a solution" do
          expect(solver).to be_solved
        end

        it "finds the shortest solution" do
          expect(solver.solution.size).to eq 4
        end

        context "when there is a one-move solution" do
          let(:start) { board.cell(9, 12) }

          it "finds a longer solution" do
            expect(solver.solution.size).to be > 1
          end
        end
      end

      context "when there are no solutions" do
        let(:goal) { Target.new(:green, :triangle) }
        let(:start) { board.cell(0, 0) }

        it "finishes without a solution" do
          expect(solver).not_to be_solved
        end
      end
    end
  end
end
