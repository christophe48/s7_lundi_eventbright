class Event < ApplicationRecord
  has_many :attendances
  has_many :users, through: :attendance
  belongs_to :administrator, class_name: "User"

  validates :start_date, presence: {message:"La date de départ doit être renseignée"}
  validate :is_gone?

  validates :duration, presence: {message:"La durée de l'évênement doit être renseignée"},
                      numericality: {greater_than: 0}
  validate :multiple_of_5?

  validates :title, presence: {message: "Le titre de l'évênement doit être présent"},
                    length: {minimum: 5, maximum: 140, message: "Le titre doit être compris entre 5 et 140 caractères"}

  validates :description, presence: {message: "La description doit être renseignée"},
                          length: {minimum: 20,maximum: 1000, message: "Le titre doit être compris entre 20 et 1000 caractères"}

  validates :price, presence: {message: "le prix doit être renseignée"},
                    numericality: { only_integer: true, greater_than: 1, less_than: 1000, message:" Le prix doit être un chiffre entier compris entre 1 et 1000" }

  validates :location, presence: {message: "Le lieu de l'évênement doit être renseigné"}

  def multiple_of_5?
    #c'est une erreur tant que c'est pas la vérité
    errors.add(:duration, "La duree doit etre un multiple de 5 !") unless
    self.duration % 5 == 0
  end

  def is_gone?
    erros.add(:start_date, " Tu ne peux pas modifier ou créer une évênement dans le passé.") unless
    self.start_date >  Time.now
  end
end
