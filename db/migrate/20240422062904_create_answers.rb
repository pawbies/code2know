class CreateAnswers < ActiveRecord::Migration[7.1]
  def change
    create_table :answers do |t|
      t.text :text
      t.references :user, null: false, foreign_key: true, foreign_key: { on_delete: :cascade }
      t.references :question, null: true, foreign_key: true, foreign_key: { on_delete: :cascade }
      t.references :answer, null: true, foreign_key: true

      t.timestamps
    end
  end
end
