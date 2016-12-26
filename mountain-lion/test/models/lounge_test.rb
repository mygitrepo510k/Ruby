require 'test_helper'

describe Lounge do
  include Sorcery::TestHelpers::Rails
  describe "#feed" do
    before do
      User.delete_all
      @uf=FactoryGirl.create(:user, gender: 'F')
      @um=FactoryGirl.create(:user, gender: 'M')
      @um.activate!
      @uf.activate!
    end
    it "must show only female feed when a user is male" do
      subject = Lounge.new('M')
      post = subject.feed.first
      post.gender.must_equal 'F'
    end
    it "must show only male feed when a user is female" do
      subject = Lounge.new('F')
      post = subject.feed.first
      post.gender.must_equal 'M'
    end
    it "assigns a gender reader" do
      subject = Lounge.new('F')
      subject.gender.must_equal 'F'
    end
  end
end
