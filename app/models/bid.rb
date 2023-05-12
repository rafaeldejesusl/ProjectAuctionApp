class Bid < ApplicationRecord
  belongs_to :lot
  belongs_to :user
  validates :value, presence: true
end
