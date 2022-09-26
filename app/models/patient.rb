class Patient < ApplicationRecord
  has_many :doctor_patients
  has_many :doctors, through: :doctor_patients

  def self.list_adults_alpha_ordered
    Patient.where("age > 18").order(:name)
  end
end