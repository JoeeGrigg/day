class Signup::Index < BrowserAction
  include RedirectToPages
  skip check_login

  get "/signup" do
    html IndexPage, op: SaveUser.new
  end
end
