class Signin::Create < BrowserAction
  post "/signin" do
    plain_text "Render something in Signin::Create"
  end
end
