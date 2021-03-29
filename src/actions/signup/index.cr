class Signup::Index < BrowserAction
  include RedirectToPages
  skip check_login

  get "/signup" do
    html IndexPage, op: SaveNewUser.new
  end
end
