class Login::Delete < BrowserAction
  delete "/login" do
    current_login.delete
    cookies.delete(Login::COOKIE_NAME)
    redirect to: Home::Index
  end
end
