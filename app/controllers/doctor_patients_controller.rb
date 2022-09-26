class DoctorPatientsController < ApplicationController

  def destroy
    doctor_patient = DoctorPatient.where(patient_id: params[:format], doctor_id: params[:id])
    DoctorPatient.delete(doctor_patient)
    redirect_to(doctor_path)
  end

end