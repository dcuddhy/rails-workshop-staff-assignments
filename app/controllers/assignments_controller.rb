class AssignmentsController < ApplicationController

  def new
    person = Person.find(params[:person_id])
    @assignment = Assignment.new(person: person)
  end

end
