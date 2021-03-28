class Signup::IndexPage < IndexLayout
  needs op : SaveUser

  def content
    h1 "Sign Up"
    para "Setting up an account is as simple as choosing a password."
    para "No email required."
    form_for Signup::Create do
      mount Shared::Field, attribute: op.password, &.password_input
      mount Shared::Field, attribute: op.password_confirmation, &.password_input
      submit "Signup"
    end
  end
end
