class Role < ApplicationRecord
  validates :name, presence: true
  validates :permission, presence: true
end
