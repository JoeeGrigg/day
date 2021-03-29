class Signup::ShowPage < IndexLayout
  needs user : User

  def content
    h1 "Signup Successful"
    para "Your new identifier is:"
    h2 user.identifier
    para "You can log in using this identifier and your chosen password."
    para do
      strong "Remember"
      text " to keep this identifier safe as you need it to log in"
    end
    link to: Login::Index do
      button "Login Now"
    end
  end
end
