# permission levels:
# 1: Basic - Normal User (Can do pretty much nothing of significance)
# 2: Elevated - Can delete reported questions
# 3: Extra Elavated - Can delete all questions
# 4: Admin - Can also delete users
# 5: Counsel Member - nothing special but sounds cool


class Role < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  validates :permission, presence: true, uniqueness: true
end
