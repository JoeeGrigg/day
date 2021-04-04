class Signup::ShowPage < IndexLayout
  needs user : User

  def content
    div class: "layout-center" do
      h1 "Signup Successful"
      para "Your new identifier is:"
      h2 user.identifier
      para "You can log in using this identifier and your chosen password."
      para do
        strong "Remember"
        text " to keep this identifier safe as you need it to log in"
      end
      link "Login Now", to: Login::Index, class: "btn btn-primary"
    end
  end
end
