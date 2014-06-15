require 'spec_helper'

describe Api::V1::UsersController, :type => :controller do 
  describe 'UsersController routes' do
    before do 
      @user = {:user => {:first_name => 'Alice', :last_name => "bootylicious", :email => 'alice@a.com', :password => 'fuckemall', :password_confirmation => 'fuckemall'} }
    end 

    it "should get the users" do 
      get 'index'
      response.body.status.should eq("failed")
    end 

    it "should raise user count " do
      get 'sign_up', @user
       response.body.status.should eq("failed")
    end 
  end
end 

  
  #   it 'should add3 user' do

  #     lambda {
  #       post 'new', 
  #     }.should change(User, :count).by(1)
  #   end



  #   it 'should add 4 user' do

  #     lambda {
  #       post 'sign_up', :user => {:first_name => 'Alice', :last_name => "bootylicious", :email => 'alice@a.com', :password => 'fuckemall', :password_confirmation => 'fuckemall'}
  #     }.should change(User, :count).by(1)
  #   end



  #   it 'should add  5 user' do

  #     lambda {
  #       post '', :user => {:first_name => 'Alice', :last_name => "bootylicious", :email => 'alice@a.com', :password => 'fuckemall', :password_confirmation => 'fuckemall'}
  #     }.should change(User, :count).by(1)
  #   end

  #   context 'after creating, the new user' do

  #     before do
  #       post '/api/users', :user => {:first_name => 'Alice', :last_name => "bootylicious", :email => 'alice@a.com', :password => 'fuckemall', :password_confirmation => 'fuckemall'}
  #       @user = User.last
  #     end
  #     subject { JSON.parse(response.body) }

  #     it 'should have the correct name and login' do
  #       @user.first_name.should == 'Alice'
  #     end
  #   end
  # end