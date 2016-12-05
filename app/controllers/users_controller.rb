require 'rack-flash'

class UsersController < ApplicationController

  use Rack::Flash

  get '/users' do
    if logged_in?
      @users = User.all
      erb :'users/users'
    else
      flash[:message] = "Please log in to access app"
      redirect '/login'
    end
  end

  get '/users/:slug' do
    if logged_in?
      @user = User.find_by_slug(params[:slug])
      erb :'users/show_user'
    else
      flash[:message] = "Please log in to access app"
      redirect '/login'
    end
  end

  get '/signup' do
    if !logged_in?
      erb :'users/signup'
    else
      redirect '/films'
    end
  end

  post '/signup' do
    if params[:username] == "" || params[:email] == "" || params[:password] == ""
      flash[:message] = "Please fill all fields to create film"
      redirect '/signup'
    else
      @user = User.new(username: params["username"], email: params["email"], password: params["password"])
      @user.save
      session[:user_id] = @user.id
      @writer = Writer.new(user_id: @user.id)
      @writer.save
      @director = Director.new(user_id: @user.id)
      @director.save
      flash[:message] = "Successfully created user"
      redirect '/films'
    end
   end

  get '/login' do
    if !logged_in?
      erb :'users/login'
    else
      redirect '/films'
    end
  end

  post '/login' do
    @user = User.find_by(username: params["username"])
    if @user && @user.authenticate(params["password"])
      session[:user_id] = @user.id
      flash[:message] = "Successfully logged in"
      redirect '/films'
    else
      flash[:message] = "User not found, please try again"
      redirect '/signup'
    end
  end

  get '/logout' do
    if logged_in?
      session.destroy
      flash[:message] = "Successfully logged out"
      redirect '/login'
    else
      redirect '/'
    end
  end

end
