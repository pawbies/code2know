class CreateJoinTableQuestionsCategories < ActiveRecord::Migration[7.1]
  def change
    create_join_table :questions, :categories do |t|
      # t.index [:question_id, :category_id]
    # t.index [:category_id, :question_id]
    end
  end
end
