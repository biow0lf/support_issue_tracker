class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.integer :ticket_id
      t.text :body
      t.string :name
      t.string :email

      t.timestamps null: false
    end

    add_index :comments, :ticket_id
  end
end
