# frozen_string_literal: true

class DeviseCreateUserRegistrations < ActiveRecord::Migration[7.1]
  def change
    create_table :user_registrations do |t|
      t.references :user, null: false, foreign_key: true, index: { unique: true }
      t.string :email, null: false, index: { unique: true }

      ## Confirmable
      t.string   :confirmation_token
      t.datetime :confirmed_at
      t.datetime :confirmation_sent_at
      t.string   :unconfirmed_email # Only if using reconfirmable

      t.timestamps null: false
    end
  end
end
