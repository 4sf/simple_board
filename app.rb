require 'sinatra'
require 'sinatra/reloader'
require 'data_mapper'
require './model'

set :bind, '0.0.0.0'

before do
  check_login
end

get '/' do
  @posts = Post.all # [1,2,3,4,...]
  erb :index
end

get '/new' do
  erb :new
end

get '/create' do
  # 글을 데이터베이스에 저장하고
  Post.create(
    title: params["title"],
    content: params["content"]
  )
  redirect to '/'
end

get '/edit/:id' do
  @post = Post.get(params[:id])
  erb :edit
end

get '/update/:id' do
  post = Post.get(params[:id])
  post.update(
    title: params[:title],
    content: params[:content]
  )
  redirect to '/'
end


get '/destroy/:id' do
  # 1번 글을 지우게 될거면
  # '/destroy/1'
  post = Post.get(params[:id])
  post.destroy
  #지울꺼얌
  redirect to '/'
end

get '/hello/:name' do
  @name = params[:name]
  erb :hello
end

# /square/3
# sqaure.erb 보내주고, 3 * 3 = 9

get '/square/:num' do
  num = params[:num].to_i
  @result = num ** 2
  erb :square
end
#
# get '/cube/:num' do
# end

get '/signup' do
  erb :signup
end

get '/register' do
  User.create(
    email: params["email"],
    password: params["password"]
  )
  redirect to '/'
end

get '/login' do
  erb :login
end

get '/login_session' do
  if User.first(email: params[:email])
    # if #비밀번호 체크
    #   # 로그인
    # end
  end
end

def check_login
  unless session[:email]
    redirect to '/'
  end
end
