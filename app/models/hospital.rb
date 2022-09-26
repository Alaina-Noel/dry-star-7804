class Hospital < ApplicationRecord
  has_many :doctors

  def doctors_orderby_patient_count
    doctors.left_joins(:patients).select("doctors.* , count(patients) as patient_count" ).group("doctors.id").order("patient_count desc")
  end
end
