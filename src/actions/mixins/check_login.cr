module CheckLogin
  macro included
    before check_login
  end

  private def check_login
    token = cookies.get?(Login::COOKIE_NAME)
    if token
      login = LoginQuery.new.token(token).first?
      unless login
        flash.failure = "Token invalid or expired"
        cookies.delete(Login::COOKIE_NAME)
        redirect to: Signin::Index
      end
      continue
    else
      flash.failure = "Please log in"
      redirect to: Signin::Index
    end
  end
end