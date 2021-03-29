module AuthenticatedRoute
  macro included
    before check_login
  end

  def current_token : String?
    cookies.get?(Login::COOKIE_NAME)
  end

  def current_login : Login?
    current_token ? LoginQuery.new.preload_user.token(current_token.as(String)).first? : nil
  end

  def current_user : User?
    current_login ? current_login.as(Login).user : nil
  end

  private def check_login
    unless current_user
      flash.failure = "Please log in"
      cookies.delete(Login::COOKIE_NAME)
      redirect to: Login::Index
    end
    continue
  end
end