class AddOauthFields < ActiveRecord::Migration
	def change
		add_column :users, :uid, :text
		add_column :users, :nickname, :text
		add_column :users, :first_name, :text
		add_column :users, :last_name, :text
		add_column :users, :gender, :text
		add_column :users, :link, :text
		add_column :users, :locale, :text
		add_column :users, :timezone, :text
		add_column :users, :username, :text
		add_column :users, :image, :text
		add_column :users, :provider, :text
		add_column :users, :verified, :text
		add_index :users, :uid
	end
end