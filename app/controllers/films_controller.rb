class FilmsController < ApplicationController

  get '/films' do
    if logged_in?
      @films = Film.all
      erb :'films/films'
    else
      redirect '/Login'
    end
  end

  get '/films/new' do

  end

end
