require 'spec_helper'

describe Badge::Codewarrior do

  describe ".allocate_to_user?" do
    let(:user) { create(:user) }
    let(:codewar1) {create(:codewar, user: user)}
    let(:codewars5) do
      5.times.map { |i|
        create(:codewar, user: user)
      }
    end
    let(:codewars7) do
      7.times.map { |i|
        create(:codewar, user: user)
      }
    end

    subject { Badge::Codewarrior.allocate_to_user?(user) }

    context "user did not complete 5 codewars challenges" do
      before do
        codewar1
      end

      it { should be_false }
    end


    context "user completed exactly 5 codewar challenges" do
      before do
        codewars5
      end

      it { should be_true }
    end

    context "user completed more than 5 codewar challenges" do
      before do
        codewars7
      end

      it { should be_true }
    end

  end
end