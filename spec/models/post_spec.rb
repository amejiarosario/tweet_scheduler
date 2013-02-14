require 'spec_helper'

describe Post do
  before :each do
    @ready = FactoryGirl.create :post, publish_on: 1.minute.ago
    @future = FactoryGirl.create :post, publish_on: 1.minute.from_now
    @sent = FactoryGirl.create :post, publish_on: 1.minute.ago, sent: true
  end
  it "should list all the post that needs to be sent" do
    Post.tweets_ready.should include(@ready)
  end

  it "should not list post that were already sent" do
    Post.tweets_ready.should_not include (@sent)
  end

  it "should not list post that are in the future" do
    Post.tweets_ready.should_not include (@future)
  end
end
