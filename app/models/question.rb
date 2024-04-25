class Question < ApplicationRecord
  belongs_to :user
  has_many :answers
  has_and_belongs_to_many :categories
end
