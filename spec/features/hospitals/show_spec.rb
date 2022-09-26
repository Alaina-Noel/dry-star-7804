require 'rails_helper'

RSpec.describe 'Hospital Show Page', type: :feature do
  describe 'As a visitor' do
    describe "When I visit a hospital's show page" do
        before :each do
          @grey_hospital = Hospital.create!(name: "Grey Sloan Memorial Hospital")
          @seaside_hospital = Hospital.create!(name: "Seaside Health & Wellness Center")
  
          @meredith = @grey_hospital.doctors.create!(name: "Meredith Grey", specialty: "General Surgery", university: "Harvard University")
          @alex = @grey_hospital.doctors.create!(name: "Alex Karev", specialty: "Pediatric Surgery", university: "Johns Hopkins University")
          @miranda = @grey_hospital.doctors.create!(name: "Miranda Bailey", specialty: "General Surgery", university: "Stanford University")
          @ryan = @grey_hospital.doctors.create!(name: "Ryan Reynolds", specialty: "Attending Surgeon", university: "Some University")
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

      it "I see the hospital's name & I see the names of all doctors that work at this hospital. The doctors are ordered by patient count" do
        # (Doctor patient counts should be a single query)
        visit hospital_path(@grey_hospital)

        expect(page).to have_content("#{@grey_hospital.name}")
        expect("#{@meredith.name}").to appear_before("#{@alex.name}")
        expect("#{@alex.name}").to appear_before("#{@miranda.name}")
        # expect("#{@miranda.name}").to appear_before("#{@ryan.name}")

        expect(page).to_not have_content("#{@derek.name}")

      end

      it 'Next to each doctor I see the number of patients associated with the doctor' do
        visit hospital_path(@grey_hospital)

        expect(page).to have_content("#{@meredith.name}: #{@meredith.patient_count} patients")
        expect(page).to have_content("#{@alex.name}: #{@alex.patient_count} patients")
        expect(page).to have_content("#{@miranda.name}: #{@miranda.patient_count} patients")
        # expect(page).to have_content("#{@ryan.name}: #{@ryan.patient_count} patients") #edge case accounting for zero


      end

    end
  end
end
