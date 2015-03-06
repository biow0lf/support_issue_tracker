class CreateTickets < ActiveRecord::Migration
  def change
    create_table :tickets do |t|
      t.string :name
      t.string :email
      t.string :summary
      t.text :body
      t.string :uid
      t.integer :status_id
      t.integer :department_id
      t.integer :user_id

      t.timestamps null: false
    end
    add_index :tickets, :uid, unique: true
    add_index :tickets, :status_id
    add_index :tickets, :department_id
    add_index :tickets, :user_id
  end
end
