class Answer < ApplicationRecord
  belongs_to :user
  belongs_to :question, optional: true
  belongs_to :answer, optional: true

  has_many :answers

  validates :text, presence: true, length: { within: 0..250 }
  #validates :helpful, presence: true

  after_initialize :set_false, unless: :persisted?

  private

  def set_false
    self.helpful ||= false
  end
  
end  
