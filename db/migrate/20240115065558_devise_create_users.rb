# frozen_string_literal: true

class DeviseCreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.string :name, null: false, index: { unique: true }
      t.string :display_name, null: true, index: { unique: true }

      ## Devise Rememberable
      t.string   :remember_token
      t.datetime :remember_created_at

      t.timestamps null: false
    end
  end
end
