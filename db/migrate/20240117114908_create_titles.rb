class CreateTitles < ActiveRecord::Migration[7.1]
  def change
    create_table :titles do |t|
      t.string :name, null: false, index: { unique: true }

      t.timestamps
    end
  end
end
