class Signin::Index < BrowserAction
  get "/signin" do
    html IndexPage
  end
end
