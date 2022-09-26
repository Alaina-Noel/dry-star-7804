class Hospital < ApplicationRecord
  has_many :doctors

  def doctors_orderby_patient_count
    #left join is here to account for edge case of doctors with zero patients but still work at that hospital
    doctors.left_joins(:patients).select("doctors.* , count(patients) as patient_count" ).group("doctors.id").order("patient_count desc")
  end
  
end
