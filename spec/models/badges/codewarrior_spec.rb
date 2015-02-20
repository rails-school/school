require 'spec_helper'

describe Badge::Codewarrior do

  describe ".allocate_to_user?" do
    let(:user) { create(:user) }

    subject { Badge::Codewarrior.allocate_to_user?(user) }

    context "user did not complete 5 codewars challenges" do
      before do
        create(:codewar, user: user)
      end

      it { should eq(false) }
    end


    context "user completed exactly 5 codewar challenges" do
      before do
        5.times.map { |i|
          create(:codewar, user: user)
        }
      end

      it { should eq(true) }
    end

    context "user completed more than 5 codewar challenges" do
      before do
        7.times.map { |i|
          create(:codewar, user: user)
        }
      end

      it { should eq(true) }
    end

  end
end
