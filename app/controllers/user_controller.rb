class UserController < ApplicationController
  def index
    if session[:user_id]
      @email = User.find(session[:user_id]).email 
    end
  end

  def new
  end

  def create
    @email = params[:user_email]
    @password = params[:user_password]
    hidden_password = Digest::MD5.hexdigest(@password)
    # db 에 들어가는 정보
    User.create(
      email: @email,
      password: hidden_password
    )
  end
  
  def login
  end
  
  def loginprocess
    if User.exists?(email: params[:user_email])
      user = User.find_by(email: params[:user_email])
      if user.password == Digest::MD5.hexdigest(params[:user_password])
          session[:user_id] = user.id
          p "로그인이 되었습니다."
          redirect_to '/'
          # 로그인이 됐을 경우, index 페이지로 넘어가고, 안될 경우 loginprocess 페이지로 넘어가 로그인이 안된 결과창이 나옴
      end
    end
  end
  
end
