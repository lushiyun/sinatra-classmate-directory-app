class ClassmatesController < ApplicationController
  before do
    login_required
  end

  get '/classmates' do
    @classmates = current_user.classmates
    erb :"/classmates/index"
  end

  # get '/classmates/new' do
  #   query = params.map{|key, value| "#{key}=#{value}"}.join("&")
  #   erb :"/classmates/new?#{query}"
  # end

  post '/classmates' do
    @course = Course.find_by(id: params[:course_id])
    @classmate = @course.classmates.find_or_create_by(name: params[:name], birthday: params[:birthday])
    unless @classmate.valid?
      flash[:alerts] = @classmate.errors.full_messages
    end
    @classmate.user = current_user
    redirect to "/courses/#{@course.id}"
  end

  get '/classmates/:id' do
    if authorized?
      erb :"classmates/show"
    else 
      reroute
    end
  end

  get '/classmates/:id/edit' do
    if authorized?
      erb :"classmates/edit"
    else 
      reroute
    end 
  end

  patch '/classmates/:id' do
    if authorized?
      if @classmate.update(params[:classmate])
        redirect to "/courses/#{@classmate.id}"
      else 
        flash[:alerts] = classmate.errors.full_messages
        redirect to "/courses/#{classmate.id}/edit"
      end
    else 
      reroute
    end
  end

  delete '/classmates/:id' do
    if authorized?
      current_user.classmates.destroy(@classmate)
      redirect to "/classmates"
    else 
      reroute
    end
  end

  private

  def authorized?
    @classmate = current_user.classmates.find_by(id: params[:id])
  end
  
  def reroute
    flash[:alerts] = ["You don't have permission"]
    redirect to "/classmates"
  end

end