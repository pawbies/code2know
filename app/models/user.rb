class User < ApplicationRecord
  belongs_to :rank
  belongs_to :role
  has_secure_password

  after_initialize :default_values, unless: :persisted?

  private

  def default_values
    self.role = Role.find_by(name: "Basic")
    self.rank = Rank.find_by(name: "Beginner")
    self.xp = 0
  end
end
