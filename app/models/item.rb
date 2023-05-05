class Item < ApplicationRecord
  validates :name, :category, :code, presence: true

  before_validation :generate_code

  private

  def generate_code
    self.code = SecureRandom.alphanumeric(10).upcase
  end
end
