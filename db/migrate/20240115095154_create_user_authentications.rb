# frozen_string_literal: true

class CreateUserAuthentications < ActiveRecord::Migration[7.1]
  def change
    create_table :user_authentications do |t|
      t.references :user, null: false, foreign_key: true, index: { unique: true }

      t.string :provider, null: false
      t.string :uid, null: false

      t.string :username
      t.string :display_name
      t.string :email
      t.string :url
      t.string :image_url

      t.timestamps
    end

    add_index :user_authentications, [:provider, :uid], unique: true
  end
end
