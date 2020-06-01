class CoursesController < ApplicationController
  before '/courses/*' do
    authentication_required
  end

  get '/courses' do
    @courses = current_user.courses
    erb :"/courses/index"
  end

  

end