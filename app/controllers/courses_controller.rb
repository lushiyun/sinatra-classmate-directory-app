class CoursesController < ApplicationController
  before do
    login_required
  end

  get '/courses' do
    @courses = current_user.courses
    erb :"courses/index"
  end

  get '/courses/new' do
    erb :"courses/new"
  end

  post '/courses' do
    @course = current_user.courses.create(params)
    if @course.valid?
      erb :"courses/show"
    else 
      flash[:alerts] = @course.errors.full_messages
      redirect to "/courses/new"
    end
  end

  post '/courses/:id/classmates' do 
    permission_required

    @classmate = current_user.find_or_create_by(name: params[:name], birthday: params[:birthday])

    flash[:alerts] = @classmate.errors.full_messages unless @classmate.valid?

    ClassmateCourse.create(course_id: @course.id, classmate_id: @classmate.id) unless @course.classmates.include?(@classmate)
    
    redirect to "/courses/#{@course.id}"
  end

  get '/courses/:id' do
    permission_required
    erb :"/courses/show"
  end

  get '/courses/:id/edit' do
    permission_required
    erb :"/courses/edit"
  end

  patch '/courses/:id' do
    permission_required
    if @course.update(params[:course])
      redirect to "/courses/#{@course.id}"
    else 
      flash[:alerts] = course.errors.full_messages
      redirect to "/courses/#{course.id}/edit"
    end
  end

  delete '/courses/:id' do
    permission_required
    current_user.courses.destroy(@course)
    redirect to "/courses"
  end

  private

  def permission_required
    unless @course = current_user.courses.find_by(id: params[:id])
      flash[:alerts] = ["You don't have permission"]
      redirect to "/courses"
    end 
  end

end