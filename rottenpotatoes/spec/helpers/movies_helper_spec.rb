require 'rails_helper'

describe "MovieHelper" do

    describe "check oddness" do
        it "should return odd if input is odd" do
            helper.oddness(1).should eql("odd")
        end
    end
end