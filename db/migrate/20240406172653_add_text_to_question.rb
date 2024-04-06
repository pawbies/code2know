class AddTextToQuestion < ActiveRecord::Migration[7.1]
  def change
    add_column :questions, :text, :string
  end
end
