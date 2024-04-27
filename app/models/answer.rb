class Answer < ApplicationRecord
  belongs_to :user
  belongs_to :question, optional: true
  belongs_to :answer, optional: true

  has_many :answers

  validates :text, length: { minimum: 0 }
  validates :text, length: { maximum: 25 }
  
end  
