class AddUserToQuestion < ActiveRecord::Migration[7.1]
  def change
    add_reference :questions, :user, null: false
  end
end
