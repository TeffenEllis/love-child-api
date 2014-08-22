class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :uuid
      t.text :description
      t.string :password_digest
      t.string :role
      t.string :email
      t.datetime :last_login
      t.datetime :last_activity

      t.timestamps
    end

    add_index :users, :name
    add_index :users, :uuid
    add_index :users, :role
    add_index :users, :email
  end
end
