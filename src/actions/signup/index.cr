class Signup::Index < BrowserAction
  get "/signup" do
    html IndexPage, op: SaveUser.new
  end
end
