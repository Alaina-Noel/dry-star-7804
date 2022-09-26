require 'rails_helper'
RSpec.describe DoctorPatient, type: :model do
  describe 'relationships' do
    it { should belong_to(:doctor) }
    it { should belong_to(:patient) }
  end

  before(:each) do
    # @instance_var = Something.create!(input)
  end

  describe 'class methods' do
    describe '#search' do
      it 'returns partial matches' do
       #method goes here
      end
    end
  end

  describe 'instance methods' do
    describe '#method_name' do
     it 'description of method' do
      #expect statement here
     end
    end
  end

end