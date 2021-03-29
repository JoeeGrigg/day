class Profile::Index < BrowserAction
  get "/profile" do
    html IndexPage, user: current_user, op: SaveProfile.new(current_user)
  end
end
