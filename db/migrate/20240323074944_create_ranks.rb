class CreateRanks < ActiveRecord::Migration[7.1]
  def change
    create_table :ranks do |t|
      t.string :name
      t.integer :level
      t.integer :threshold

      t.timestamps
    end
    add_index :ranks, :name, unique: true
  end
end
