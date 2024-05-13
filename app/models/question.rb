class Question < ApplicationRecord
  belongs_to :user
  has_many :answers, dependent: :delete_all
  has_many :reports, dependent: :delete_all
  has_and_belongs_to_many :categories

  before_destroy :remove_category_associatations

  validates :heading, presence: true
  validates :heading, length: { minimum: 0 }
  validates :heading, length: { maximum: 75 }

  validates :text, presence: true
  validates :text, length: { minimum: 0 }
  validates :text, length: { maximum: 3000 }

  private

  def remove_category_associatations
    categories.clear
  end
end
