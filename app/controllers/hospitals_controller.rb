class HospitalsController < ApplicationController

 def show
  require 'pry' ; binding.pry
  @hospital = Hospital.find(params[:id])
 end
end