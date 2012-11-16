require_relative "config/environment"
require "sinatra"
require "omniauth"

set :port, ENV["PORT"] || 4567

use Rack::Session::Cookie
use OmniAuth::Strategies::Developer

helpers do
	def logged_in?
		session["user_id"]
	end

	def user
		User.find session["user_id"]
	end
end

get "/" do
	@messages = Message.find :all if logged_in?
	erb :index
end

post "/auth/developer/callback" do
	@user = User.find_by_email params["email"]
	@user ||= User.create! :email => params["email"], :name => params["name"]
	session["user_id"] = @user.id
	redirect "/"
end

post "/messages" do
	user.messages.create! :body => params["body"]
	redirect "/"
end

get "/logout" do
	session.clear
	redirect "/"
end

after do
  ActiveRecord::Base.clear_active_connections!
end