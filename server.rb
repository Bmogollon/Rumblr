require "sinatra/activerecord"
require 'sinatra'

enable :sessions


set :database, {adapter: "sqlite3", database: "database.sqlite3"}

class User < ActiveRecord::Base

end

class Spost < ActiveRecord::Base

end


get '/' do
    p session

    erb :home
end
#####################
# SING IN

get "/login" do

  erb :"/users/login"
end

post "/login" do
  user = User.find_by(email: params["email"])
  puts "this: #{user}"

  if user != nil
    if user.password == params["password"]
      session[:user_id] = user.id
      redirect "/users/#{user.id}"
    end
  end
end


post "/logout" do

  session["user_id"] = nil
  redirect "/"
end

####
# # SIGN UP
get "/users/signup" do
  if session['user_id'] != nil
    p "User already logged in"
    redirect "/"
  else
    erb :'/users/signup'
  end

end

post "/users/signup" do
  @user =  User.new(name: params[:name], email: params[:email], birthday: params[:birthday], password: params[:password])
  @user.save
  session[:user_id] = @user.id
  redirect "/users/#{@user.id}"
end


get "/users/:id" do
  @user =  User.find(params["id"])
  erb :"/users/profile"
end


get "/sposts/spost" do
  if session['user_id'] == nil
    p 'User was not logged in'
    redirect '/'
    end
    erb :"sposts/spost"
end

post "/sposts/spost" do #CREATE
  @spost = Spost.new(title: params[:title], content: params[:content], user_id: params[:user_id])
  @spost.save
  redirect "/sposts/#{@spost.id}"
end
### SEE ALL POST
get '/sposts/allp' do
  @sposts = Spost.all
  erb :'/sposts/allp'
end

######


get "/sposts/:id" do
  @spost =  Spost.find(params["id"])
  erb :"/sposts/content"
end


#to DELETE an spost, be careful on what you're writing on here!
get "/sposts/?" do
  @sposts = Spost.all
  erb :"/sposts/content"
end

post "/sposts/:id" do
  @spost =  Spost.find(params["id"])
  @spost.destroy

  redirect "/sposts/allp"
end
