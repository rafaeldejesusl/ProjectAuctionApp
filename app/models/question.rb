class Question < ApplicationRecord
  belongs_to :user
  belongs_to :lot
  has_one :answer
  validates :content, presence: true
end
