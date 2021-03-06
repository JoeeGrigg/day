class Signup::IndexPage < IndexLayout
  needs op : SaveNewUser

  def content
    div class: "layout-center" do
      h1 "Sign Up"
      para "Setting up an account is as simple as choosing a password."
      para "No email required."
      para "For safety you can set a recovery email after sign up."
      form_for Signup::Create do
        mount Shared::Field, attribute: op.password, &.password_input
        mount Shared::Field, attribute: op.password_confirmation, &.password_input
        submit "Signup", class: "btn btn-primary"
      end
      br
      link "Already have an account?", to: Login::Index
    end
  end
end
