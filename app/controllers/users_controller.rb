class UsersController < ApplicationController

  get '/signup' do
    if !logged_in?
      erb :'users/signup'
    else
      redirect '/films'
    end
  end

  post '/signup' do

  end

  get '/login' do
    if !logged_in?
      erb :'users/login'
    else
      redirect '/films'
    end
  end
  

end
