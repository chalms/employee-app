require 'spec_helper'

describe Metrics do
  it "should fuck" do 
    expect { User.create!({:email => "andrew@chalmers.com", :password => "password", :name => "Andrew Chalmers"}) }.to(raise error)
  end 
end
