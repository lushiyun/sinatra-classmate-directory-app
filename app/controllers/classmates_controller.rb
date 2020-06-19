class ClassmatesController < ApplicationController
  before do
    login_required
  end


  get '/classmates' do
    @classmates = current_user.classmates
    erb :"/classmates/index"
  end

  # get '/classmates/new' do
  #   @courses = current_user.courses
  #   erb :"/classmates/new"
  # end

  # post '/classmates' do
  #   @classmate = current_user.classmates.create(params[:classmate])
  #   create_or_update_classmate
  # end

  get '/classmates/:id' do
    permission_required
    erb :"classmates/show"
  end

  get '/classmates/:id/edit' do
    permission_required
    @courses = current_user.courses
    erb :"classmates/edit"
  end

  patch '/classmates/:id' do
    permission_required
    @classmate.update(params[:classmate])
    create_or_update_classmate
  end

  delete '/classmates/:id' do
    permission_required
    @classmate.destroy
    redirect to "/classmates"
  end

  private

  def permission_required
    unless @classmate = current_user.classmates.find_by(id: params[:id])
      flash[:alerts] = ["You don't have permission"]
      redirect to "/classmates"
    end
  end

  def create_or_update_classmate
    unless @classmate.valid?
      flash[:alerts] = @classmate.errors.full_messages
    end

    unless params[:course][:title].empty?
      course = current_user.courses.find_or_create_by(params[:course])
      ClassmateCourse.create(course_id: course.id, classmate_id: @classmate.id)
    end
    
    redirect to "/classmates/#{@classmate.id}"
  end

end