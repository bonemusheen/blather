require_relative "config/environment"
require "sinatra"
require "omniauth"
require "omniauth-facebook"
require "omniauth-google-oauth2"

set :port, ENV["PORT"] || 4567

configure :production do
	require 'rack/ssl'
	use Rack::SSL
end

use Rack::Session::Cookie
use OmniAuth::Builder do
	provider :facebook, ENV['FACEBOOK_ACCT'], ENV['FACEBOOK_SECRET_BLATHER']
	provider :google_oauth2, ENV['GOOGLE_ACCT'], ENV['GOOGLE_SECRET_BLATHER']
end

helpers do
	include Rack::Utils
  	alias_method :h, :escape_html
	
	def logged_in?
		session["user_id"]
	end

	def user
		User.find session["user_id"]
	end
end

get "/" do
	erb :index
end

get "/messages" do
	@messages = Message.find(:all, :limit => 10, :order => "created_at DESC").reverse
	erb :messages, :layout => false
end

get "/auth/:provider/callback" do
	auth = request.env["omniauth.auth"]
  oauth_fields = %w(email nickname name first_name last_name gender link locale timezone username image provider verified)  
  user = User.where(:uid => auth["uid"]).first_or_create(auth["info"].select do |k,v|
    oauth_fields.include? k 
  end)
  session[:user_id] = user.id
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