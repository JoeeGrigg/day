class Signin::Index < BrowserAction
  skip check_login

  # TODO: Add redirect to pages if already logged in
  
  get "/signin" do
    html IndexPage, op: SaveLogin.new
  end
end
