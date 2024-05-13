class Question < ApplicationRecord
  belongs_to :user
  has_many :answers
  has_many :reports
  has_and_belongs_to_many :categories

  validates :heading, presence: true
  validates :heading, length: { minimum: 0 }
  validates :heading, length: { maximum: 75 }

  validates :text, presence: true
  validates :text, length: { minimum: 0 }
  validates :text, length: { maximum: 3000 }
end
