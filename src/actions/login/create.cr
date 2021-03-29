class Login::Create < BrowserAction
  include RedirectToPages
  skip check_login
  
  post "/login" do
    SaveLogin.create(params) do |operation, login|
      if login
        flash.success = "Successfully logged in"
        cookies.set(Login::COOKIE_NAME, login.token)
        redirect to: Pages::Index
      else
        flash.failure = "Failed to log in"
        html Login::IndexPage, op: operation
      end
    end
  end
end
