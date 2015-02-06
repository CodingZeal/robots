require 'spec_helper'

module Robots
  describe Robot do
    subject(:robot) { described_class.new(at: start, on: board) }

    let(:board) { Board.new }
    let(:start) { Position.new(row: 11, column: 6) }

    describe 'movement' do
      it 'moves north' do
        robot.north
        expect(robot.position).to eq Position.new(row: board.top, column: start.column)
      end

      it 'moves west' do
        robot.west
        expect(robot.position).to eq Position.new(row: start.row, column: board.left)
      end

      it 'moves south' do
        robot.south
        expect(robot.position).to eq Position.new(row: board.bottom, column: start.column)
      end

      it 'moves east' do
        robot.east
        expect(robot.position).to eq Position.new(row: start.row, column: board.right)
      end
    end
  end
end
