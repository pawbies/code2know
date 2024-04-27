class Question < ApplicationRecord
  belongs_to :user
  has_many :answers
  has_and_belongs_to_many :categories

  validates :heading, length: { minimum: 0 }
  validates :heading, length: { maximum: 25 }

  validates :text, length: { minimum: 0 }
  validates :text, length: { maximum: 1000 }
end
