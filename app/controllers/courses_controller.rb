class CoursesController < ApplicationController
  before do
    authentication_required
  end

  get '/courses' do
    @courses = current_user.courses
    erb :"/courses/index"
  end

  get '/courses/new' do
    erb :"/courses/new"
  end

end