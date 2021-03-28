class Signin::IndexPage < IndexLayout
  def content
    h1 "Sign In"
    form_for Signin::Create do
      input name: "identifier"
      input type: "password", name: "password"
      submit "Log In"
    end
  end
end
