# frozen_string_literal: true

class User < ApplicationRecord
  belongs_to :company
  accepts_nested_attributes_for :company
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :validatable,
    :confirmable

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  VALID_PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?[A-Z])(?=.*?\d)[a-zA-Z\d]+\z/
  validates :email, presence: true, uniqueness: true, format: { with: VALID_EMAIL_REGEX }
  validates :name,  presence: true, length: { in: 1..10 }
  validates :age,   allow_nil: true, numericality: { greater_than_or_equal_to: 10 }
  validates :password, length: { minimum: 12 },
              format: { with: VALID_PASSWORD_REGEX, message: 'パスワードは半角12文字以上で英大文字・小文字・数字それぞれ１文字以上含む必要があります' }
  enum gender: { male: 0, female: 1, other: 2 }
  enum role: { another: 0, admin: 1 }
end
