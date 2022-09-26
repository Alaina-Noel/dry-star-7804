require 'rails_helper'

RSpec.describe 'doctors show page', type: :feature do
  describe 'As a visitor' do
    describe 'When I visit the doctors show page' do
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

      it 'I see all of that doctors name, specialty, university where they got their doctorate' do

        visit doctor_path(@meredith)

        expect(page).to have_content('Meredith Grey')
        expect(page).to have_content('General Surgery')
        expect(page).to have_content('Harvard University')
        expect(page).to_not have_content('Alex Karev')
        expect(page).to_not have_content('Pediatric Surgery')
        expect(page).to_not have_content('University of Pennsylvania')
      end

      it 'And I see the name of the hospital where this doctor works & the names of all of the patients this doctor has' do
       
        visit doctor_path(@meredith)
       
        expect(page).to have_content('Grey Sloan Memorial Hospital')
        expect(page).to_not have_content('Seaside Health & Wellness Center')
        within('#patients_list') do 
          expect(page).to have_content("#{@katie.name}")
          expect(page).to have_content("#{@denny.name}")
          expect(page).to have_content("#{@rebecca.name}")
          expect(page).to have_content("#{@zola.name}")
          expect(page).to_not have_content("#{@alaina.name}")
        end
      end

      it "Next to each patients name, I see a button to remove that patient from that doctors caseload, When I click that button for one patient I'm brought back to the Doctor's show page And I no longer see that patient's name listed" do
       
        visit doctor_path(@meredith)
        expect(page).to have_content("#{@katie.name}")

        within("#patient_#{@katie.id}") do 
          expect(page).to have_content("#{@katie.name}")
          expect(page).to have_button("Remove From Caseload")
          click_button('Remove From Caseload')
        end

        expect(current_path).to eq(doctor_path(@meredith))
        expect(page).to_not have_content("#{@katie.name}")
        expect(page).to have_content("#{@denny.name}")
      end


    end
  end
end
