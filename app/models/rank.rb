class Rank < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  validates :level, presence: true, uniqueness: true
end
