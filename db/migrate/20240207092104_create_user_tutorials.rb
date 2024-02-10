class CreateUserTutorials < ActiveRecord::Migration[7.1]
  def change
    create_table :user_tutorials do |t|
      t.references :user, null: false, foreign_key: true
      t.string :page, null: false

      t.timestamps
    end

    add_index :user_tutorials, [:user_id, :page], unique: true
  end
end
