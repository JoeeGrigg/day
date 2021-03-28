class Signup::Index < BrowserAction
  skip check_login

  get "/signup" do
    html IndexPage, op: SaveUser.new
  end
end
