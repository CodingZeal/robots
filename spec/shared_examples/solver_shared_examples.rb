module Robots
  RSpec.shared_examples "a solver" do
    let(:board) { Board.example }
    let(:state) { BoardState.new(robots, goal) }
    let(:solver) { described_class.new(state) }
    let(:outcome) { solver.outcome }

    context "with a single robot" do
      let(:robot) { Robot.new(:green, start) }
      let(:robots) { [robot] }

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
          expect(outcome.final_state.robots.first).to eq Robot.new(:green, board.cell(9, 2))
        end

        context "when there is a one-move solution" do
          let(:start) { board.cell(9, 12) }

          it "finds a longer solution" do
            expect(outcome.length).to be > 1
          end

          context "when the longer solution needs to retrace the shorter solution" do
            let(:start) { board.cell(9, 5) }

            it "finds the retraced solution" do
              expect(outcome.length).to eq 5
            end
          end
        end

        context "when the robot starts on the goal" do
          let(:start) { board.cell(9, 2) }

          it "finds a different solution" do
            expect(outcome.length).to eq 4
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
          expect(outcome.final_state.robots.first).to eq robot
        end
      end
    end

    describe "with two robots" do
      let(:robot) { Robot.new(:green, board.cell(6, 15)) }
      let(:robots) { [robot, other_robot] }
      let(:goal) { Target.new(:green, :circle) }

      context "when the second robot doesn't need to move" do
        let(:other_robot) { Robot.new(:silver, board.cell(10, 12)) }

        it "finds a solution" do
          expect(outcome).to be_mission_accomplished
        end

        it "ricochets off the silver robot" do
          expect(outcome.length).to eq 3
        end
      end

      context "when the second robot moves" do
        let(:other_robot) { Robot.new(:silver, board.cell(10, 10)) }

        it "finds a solution" do
          expect(outcome).to be_mission_accomplished
        end

        it "moves the silver robot to ricochet off of it" do
          expect(outcome.length).to eq 4
        end
      end
    end
  end
end
