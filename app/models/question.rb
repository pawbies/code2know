class Question < ApplicationRecord
  has_rich_text :text
  belongs_to :user
end
