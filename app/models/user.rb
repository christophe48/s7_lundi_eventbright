class User < ApplicationRecord
  has_many :attendances
  has_many :events, through: :attendance

  validates :email, format: { with: /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/, message: "L'email doit être renseigné au bon format (email@eamil.email) !"},
            uniqueness: true
end
