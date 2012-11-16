class InitDatabase < ActiveRecord::Migration
	def change
		create_table :messages do |t|
			t.text :user, :null => false
			t.text :body, :null => false
			t.timestamps
		end
	end
end