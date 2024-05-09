class Report < ApplicationRecord
  belongs_to :question
  belongs_to :user

  validates :message, length: { within: 0..250 }
end
