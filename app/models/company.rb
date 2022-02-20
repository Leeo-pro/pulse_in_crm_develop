class Company < ApplicationRecord
  before_create :set_uuid
  has_many :users

  private

  def set_uuid
    self.id = SecureRandom.uuid while self.id.blank? || Company.find_by(id: self.id).present?
  end
end
