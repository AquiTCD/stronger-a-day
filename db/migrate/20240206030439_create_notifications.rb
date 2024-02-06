class CreateNotifications < ActiveRecord::Migration[7.1]
  def change
    create_table :notifications do |t|
      t.string :subject, null: false
      t.text :content, null: false
      t.string :importance, null: false, default: "normal"

      t.datetime :released_at, null: true
      t.datetime :closed_at, null: true

      t.timestamps
    end
  end
end
