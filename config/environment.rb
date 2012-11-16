require "bundler/setup"
require "active_record"
require_relative "../lib/message"
require_relative "../lib/user"

ActiveRecord::Base.establish_connection ENV["DATABASE_URL"] || "sqlite3:///db/database.sqlite"