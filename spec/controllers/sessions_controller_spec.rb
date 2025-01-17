# sessions_controller_spec.rb
require 'spec_helper'
require 'rails_helper'
require 'factory_girl_rails'
 
describe SessionsController do
 
  before :each do
    # request.env['omniauth.auth'] = OmniAuth::AuthHash.new({ :provider => 'twitter', :uid => '1232354346', :name => 'something' })
    request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:twitter]
    # env = []
    # puts request.env.class
    # env["omniauth.auth"] = OmniAuth.config.mock_auth[:twitter]
    OmniAuth.config.test_mode = true
  end
 
  describe "#create" do

    it "should successfully create a user" do
    #   # visit '/auth/twitter'
    #   expect {
    #     post :create
    #   }.to change{ User.count }.by(1)
    puts request.env['omniauth.auth']

      user_count = User.count
      puts user_count
      # user = User.from_omniauth(env["omniauth.auth"])
      # puts user.inspect
      # user = create(:user)
      post :create
      puts "current user: #{current_user.inspect}"
      expect(user_count).to be > User.count
    end

    # it "should successfully create a session" do
    #   session[:user_id].should be_nil
    #   post :create, provider: :twitter
    #   session[:user_id].should_not be_nil
    # end
 
    # it "should redirect the user to the root url" do
    #   post :create, provider: :twitter
    #   response.should redirect_to root_url
    # end
 
  end
 
  # describe "#destroy" do
  #   before do
  #     post :create, provider: :twitter
  #   end
 
  #   it "should clear the session" do
  #     session[:user_id].should_not be_nil
  #     delete :destroy
  #     session[:user_id].should be_nil
  #   end
 
  #   it "should redirect to the home page" do
  #     delete :destroy
  #     response.should redirect_to root_url
  #   end
  # end
 
end