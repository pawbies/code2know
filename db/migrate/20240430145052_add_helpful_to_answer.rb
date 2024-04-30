class AddHelpfulToAnswer < ActiveRecord::Migration[7.1]
  def change
    add_column :answers, :helpful, :boolean
  end
end
