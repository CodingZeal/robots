require "spec_helper"

module Robots
  describe Position do
    subject(:position) { described_class[3, 5] }

    describe "comparison" do
      let(:different_row) { described_class[2, 5] }
      let(:different_column) { described_class[3, 1] }

      it { is_expected.to eq subject }
      it { is_expected.to eq subject.dup }
      it { is_expected.not_to eq different_row }
      it { is_expected.not_to eq different_column }
    end

    describe "immutable movement" do
      it "returns a clone in a different row" do
        expect(position.with_row(42)).to eq described_class[42, 5]
      end

      it "returns a clone in a different column" do
        expect(position.with_column(42)).to eq described_class[3, 42]
      end
    end

    describe "enumeration" do
      it "yields each position above itself" do
        enum = position.each_above
        (1..3).each do |delta|
          expect(enum.next).to eq position.with_row(position.row - delta)
        end
      end

      it "yields each position below itself" do
        enum = position.each_below
        (1..3).each do |delta|
          expect(enum.next).to eq position.with_row(position.row + delta)
        end
      end
    end
  end
end
