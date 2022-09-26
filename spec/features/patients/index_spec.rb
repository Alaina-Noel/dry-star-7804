require 'rails_helper'

RSpec.describe 'patient index page', type: :feature do
  describe 'As a visitor' do
    describe 'When I visit the patient index page' do
      before :each do
        @grey_hospital = Hospital.create!(name: "Grey Sloan Memorial Hospital")
        @seaside_hospital = Hospital.create!(name: "Seaside Health & Wellness Center")

        @meredith = @grey_hospital.doctors.create!(name: "Meredith Grey", specialty: "General Surgery", university: "Harvard University")
        @alex = @grey_hospital.doctors.create!(name: "Alex Karev", specialty: "Pediatric Surgery", university: "Johns Hopkins University")
        @miranda = @grey_hospital.doctors.create!(name: "Miranda Bailey", specialty: "General Surgery", university: "Stanford University")
        @derek = @seaside_hospital.doctors.create!(name: "Derek McDreamy Shepherd", specialty: "Attending Surgeon", university: "University of Pennsylvania")

        @katie = Patient.create!(name: "Katie Bryce", age: 24)
        @denny = Patient.create!(name: "Denny Nuquette", age: 39)
        @rebecca = Patient.create!(name: "Rebecca Pope", age: 32)
        @zola = Patient.create!(name: "Zola Shepherd", age: 2)
        @alaina = Patient.create!(name: "Alaina Kneiling", age: 18)

        @meredith_katie = DoctorPatient.create!(doctor_id: @meredith.id, patient_id: @katie.id)
        @meredith_denny = DoctorPatient.create!(doctor_id: @meredith.id, patient_id: @denny.id)
        @meredith_rebecca = DoctorPatient.create!(doctor_id: @meredith.id, patient_id: @rebecca.id)
        @meredith_zola = DoctorPatient.create!(doctor_id: @meredith.id, patient_id: @zola.id)

        @alex_denny = DoctorPatient.create!(doctor_id: @alex.id, patient_id: @denny.id)
        @alex_rebecca = DoctorPatient.create!(doctor_id: @alex.id, patient_id: @rebecca.id)
        @alex_zola = DoctorPatient.create!(doctor_id: @alex.id, patient_id: @rebecca.id)

        @miranda_zola = DoctorPatient.create!(doctor_id: @miranda.id, patient_id: @zola.id)
        @miranda_alaina = DoctorPatient.create!(doctor_id: @miranda.id, patient_id: @alaina.id)
       end

      it 'I see the names of all adult patients (age > 18) in ascending alphabetical order' do
        # (A - Z, you do not need to account for capitalization)
        visit patients_path
        
        expect(page).to_not have_content("#{@zola.name}")
        expect(page).to_not have_content("#{@alaina.name}") #edge case being 18 exactly

        expect("#{@denny.name}").to appear_before("#{@katie.name}")
        expect("#{@katie.name}").to appear_before("#{@rebecca.name}")
      end


    end
  end
end
