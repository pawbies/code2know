class Answer < ApplicationRecord
  belongs_to :user
  belongs_to :question, optional: true
  belongs_to :answer, optional: true

  
