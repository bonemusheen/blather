class CreateUser < ActiveRecord::Migration
	def change
		remove_column :messages, :user

		create_table :users do |t|
			t.text :name, :null => false
			t.text :email, :null => false
			t.text :color
		end

		add_column :messages, :user_id, :integer
	end
end
