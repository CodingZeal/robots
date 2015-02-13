require "spec_helper"

module Robots
  describe Target do
    let(:target) { Target.new(:red, :circle) }

    describe "initialization" do
      it "takes a single 'vortex' argument" do
        expect(Target.new(:vortex).shape).to eq :vortex
      end

      describe "normalizing arguments" do
        let(:target) { Target.new("rEd", "triAngLe") }

        it "converts colors to symbols" do
          expect(target.color).to eq :red
        end

        it "converts shapes to symbols" do
          expect(target.shape).to eq :triangle
        end
      end
    end

    describe "color matching" do
      it "matches the same color" do
        expect(target.matches_color?(:red)).to be true
      end

      it "doesn't match a different color" do
        expect(target.matches_color?(:green)).to be false
      end

      context "with the vortex" do
        let(:target) { Target.vortex }

        it "matches any color" do
          %i(red green blue yellow silver).each do |color|
            expect(target.matches_color?(color)).to be true
          end
        end
      end
    end
  end
end
