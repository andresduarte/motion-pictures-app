class FilmsController < ApplicationController

  get '/films' do
    if logged_in?
      @films = Film.all.uniq
      erb :'films/films'
    else
      redirect '/Login'
    end
  end

  get '/films/new' do
    if logged_in?
      erb :'films/create_film'
    else
      redirect 'login'
    end
  end

  get '/films/:id' do
    if logged_in?
      @film = Film.find_by_id(params[:id])
      erb :'films/show_film'
    else
      redirect '/login'
    end
  end

end
