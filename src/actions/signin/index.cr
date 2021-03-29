class Signin::Index < BrowserAction
  include RedirectToPages
  skip check_login
  
  get "/signin" do
    html IndexPage, op: SaveLogin.new
  end
end
