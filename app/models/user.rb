class User < ApplicationRecord
  belongs_to :rank
  belongs_to :role

  has_many :questions
  
  has_secure_password

  after_initialize :default_values, unless: :persisted?

  private

  def default_values
    self.role = Role.find_by(permission: 1)
    self.rank = Rank.find_by(level: 1)
    self.xp = 0
  end
end
