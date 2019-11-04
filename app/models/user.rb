class User < ApplicationRecord
  after_create :welcome_send

  def welcome_send
    UserMailer.welcome_email(self).deliver_now
  end

  
  has_many :attendances
  has_many :events, through: :attendance

  validates :email, format: { with: /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/, message: "L'email doit être renseigné au bon format (email@eamil.email) !"},
            uniqueness: true


end
