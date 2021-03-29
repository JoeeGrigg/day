class Login::Index < BrowserAction
  include RedirectToPages
  skip check_login
  
  get "/login" do
    html IndexPage, op: SaveLogin.new
  end
end
