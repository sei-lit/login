require 'bundler/setup'
Bundler.require
require 'sinatra/reloader' if development?
require './models'
enable :sessions

get '/' do
  
end

get '/signin' do
  erb :sign_in
end

get '/signup' do
  erb :sign_up
end

post '/signin' do
  user = User.find_by(mail: params[:mail])
  if user && user.authenticate(params[:password])
    session[:user] = user.id
    redirect '/home'
  else
    redirect '/signin'
  end
end

post '/signup' do
  user = User.create(nickname: params[:nickname], mail: params[:mail], password: params[:password], password_confirmation: params[:password_confirmation])
  if user.persisted?
    session[:user] = user.id
    redirect '/home'
  else
    redirect '/signup'
  end
end

get '/home' do
  erb :index
end

