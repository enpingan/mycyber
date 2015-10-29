class CreateComments < ActiveRecord::Migration
  def change
    create_table :Comments do |t|
      t.integer :user_id
      t.string :user_email
      t.integer :ticket_id
      t.string :ticket_name
      t.string :user_name
      t.text :content

      t.timestamps null: false
    end
  end
end
