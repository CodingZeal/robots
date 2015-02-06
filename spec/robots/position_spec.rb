require "spec_helper"

module Robots
  describe Position do
    subject(:position) { described_class.new(row: 3, column: 5) }

    describe "comparison" do
      let(:different_row) { described_class.new(row: 2, column: 5) }
      let(:different_column) { described_class.new(row: 3, column: 1) }

      it { is_expected.to eq subject }
      it { is_expected.to eq subject.dup }
      it { is_expected.not_to eq different_row }
      it { is_expected.not_to eq different_column }
    end

    describe "immutable movement" do
      it "returns a clone in a different row" do
        expect(position.with_row(42)).to eq described_class.new(row: 42, column: 5)
      end

      it "returns a clone in a different column" do
        expect(position.with_column(42)).to eq described_class.new(row: 3, column: 42)
      end
    end
  end
end
