class Signup::Show < BrowserAction
  skip check_login
  
  get "/signup/:user_id" do
    user = UserQuery.find(user_id)
    html ShowPage, user: user
  end
end
