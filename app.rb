require 'bundler/setup'
Bundler.require
require 'sinatra/reloader' if development?
require './models'

enable :sessions

get '/' do
    user_id = session[:user]
    if user_id
        erb :index
    else
        redirect "/signin"
    end
end

get "/signin" do
    erb :sign_in
end

post "/signin" do
    user = Users.find_by(email: params[:email])
    if user && user.authenticate(params[:password_digest])
        session[:user] = user.id
        redirect "/"
    else
        redirect "signin"
    end
end

get "/signup" do
    erb :sign_up
end

post "/signup" do
    user = Users.create(name: params[:name], email: params[:email], password_digest: params[:password_digest])
    if user.persisted?
        session[:user] = user.id
        redirect "/"
    else
        redirect "signup"
    end
end

