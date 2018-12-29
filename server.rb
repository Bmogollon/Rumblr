require "sinatra/activerecord"
require 'sinatra'

enable :sessions

if ENV['RACK_ENV']
  ActiveRecord::Base.establish_connection(ENV['DATABASE_URL'])

else
  set :database, {adapter: "sqlite3", database: "database.sqlite3"}
end

class User < ActiveRecord::Base
has_many :article, dependent: :destroy
end

class Article < ActiveRecord::Base
  belongs_to :user
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

  if user != nil
    if user.password == params["password"]
      session[:user_id] = user.id
      redirect "/users/#{user.id}"
    else
      redirect "/"
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
    redirect "/"
  else
    erb :'/users/signup'
  end

end

post "/users/signup" do
  @user =  User.new(first_name: params[:first_name],last_name: params[:last_name], email: params[:email], birthday: params[:birthday], password: params[:password])
  @user.save
  session[:user_id] = @user.id
  redirect "/users/#{@user.id}"
end


get "/users/:id" do
  @user =  User.find(params["id"])
  erb :"/users/profile"

  end

get "/users/?" do
  @user =  User.all
    erb :"/users/profile"

    end

post "/users/:id" do
  @user =  User.find(params["id"])
  @user.destroy


    session["user_id"] = nil
    redirect "/"
end


# **************
# POST
get "/articles/article" do
  if session['user_id'] == nil
    redirect '/'
    end
    erb :"articles/article"
end

post "/articles/article" do #CREATE
  @article = Article.new(title: params[:title], content: params[:content], user_id: session[:user_id])
  @article.save
  redirect "/articles/my-article"
end
### SEE ALL POST
get "/articles/my-article" do
  @articles = Article.last(20)
  erb :"/articles/my-article"
end

######

get "/articles/all-article" do
  @articles = Article.last(20)
  erb :"/articles/all-article"
end
get "/articles/?" do
  @articles = Article.last(20)
  erb :"/articles/all-article"
end


post "/articles/:id" do
  @article =  Article.find(params["id"])
  @article.destroy

  redirect "/articles/my-article"
end



get "/articles/all-article" do
  @article = Article.last(20)

  erb :"/articles/all-article"
end

get "/articles/:id" do
  @article =  Article.find(params["id"])
  redirect "/articles/all-article"
end
