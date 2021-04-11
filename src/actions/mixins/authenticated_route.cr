module AuthenticatedRoute
  macro included
    before check_login
  end

  # TODO: Start memoizing methods within each request to improve number of queries

  def current_token? : String?
    cookies.get?(Login::COOKIE_NAME)
  end

  def current_token : String
    current_token?.as(String)
  end

  def current_login? : Login?
    current_token? ? LoginQuery.new.preload_user.token(current_token).first? : nil
  end

  def current_login : Login
    current_login?.as(Login)
  end

  def current_user? : User?
    current_login? ? current_login.user : nil
  end

  def current_user : User
    current_user?.as(User)
  end

  private def check_login
    unless current_user?
      flash.failure = "Please log in"
      cookies.delete(Login::COOKIE_NAME)
      redirect to: Login::Index
    end
    continue
  end
end