class Item < ApplicationRecord
  belongs_to :lot, optional: true
  validates :name, :category, :code, :description, :weight, :width, :height, :depth, presence: true

  before_validation :generate_code

  private

  def generate_code
    self.code = SecureRandom.alphanumeric(10).upcase
  end
end
