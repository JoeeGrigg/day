class Profile::Update < BrowserAction
  put "/profile" do
    SaveProfile.update(current_user, params) do |operation, user|
      flash.success = "Saved" if operation.saved?
      html Profile::IndexPage, op: operation, user: user
    end
  end
end
