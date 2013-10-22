require 'spec_helper'

describe ApplicationHelper do

  describe :twitterized_type do
    it "returns the twitterized type for alert" do
      twitterized_type(:alert).should == "alert alert-warning"
    end

    it "returns the twitterized type for error" do
      twitterized_type(:error).should == "alert alert-danger"
    end

    it "returns the twitterized type for notice" do
      twitterized_type(:notice).should == "alert alert-info"
    end

    it "returns the twitterized type for success" do
      twitterized_type(:success).should == "alert alert-success"
    end

    it "returns the twitterized type for anything else as info" do
      twitterized_type("").should == "alert alert-info"
    end
  end

end
