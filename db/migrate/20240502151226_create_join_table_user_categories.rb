class CreateJoinTableUserCategories < ActiveRecord::Migration[7.1]
  def change
    create_join_table :users, :categories do |t|
      # t.index [:user_id, :user_id]
      # t.index [:category_id, :question_id]
    end
  end
end
