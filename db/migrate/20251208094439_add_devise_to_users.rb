# frozen_string_literal: true

class AddDeviseToUsers < ActiveRecord::Migration[5.0]
  def self.up
    # 1. REMOVE: The line creating the 'email' column (it already exists)
    change_table :users do |t|
      # t.string :email, null: false, default: "" # REMOVE THIS LINE

      ## Database authenticatable (KEEP)
      t.string :encrypted_password, null: false, default: ''

      ## Recoverable (KEEP)
      t.string :reset_password_token
      t.datetime :reset_password_sent_at

      ## Rememberable (KEEP)
      t.datetime :remember_created_at

      # ... Keep other Devise columns you want (Trackable, Confirmable, Lockable) ...
    end

    # 3. ADD: The essential unique index on the existing 'email' column
    add_index :users, :email, unique: true
    add_index :users, :reset_password_token, unique: true
    # ... Keep other index additions ...

    # 4. REMOVE: The old, unencrypted 'password' column from your original migration
    remove_column :users, :password, :string
  end

  # The down method needs to be modified to handle the rollback
  def self.down
    # Re-add the old password column
    add_column :users, :password, :string

    # Remove the Devise fields
    change_table :users do |t|
      t.remove :encrypted_password
      t.remove :reset_password_token
      t.remove :reset_password_sent_at
      t.remove :remember_created_at
    end

    # Remove Devise indexes
    remove_index :users, :reset_password_token
    remove_index :users, :email # Removing the index
  end
end
