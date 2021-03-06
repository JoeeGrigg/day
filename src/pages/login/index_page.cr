class Login::IndexPage < IndexLayout
  needs op : SaveLogin

  def content
    div class: "layout-center" do
      h1 "Sign In"
      form_for Login::Create do
        # TODO: If string that isn't a UUID passed in an error is raised
        mount Shared::Field, attribute: op.identifier
        mount Shared::Field, attribute: op.password, &.password_input
        submit "Log In", class: "btn btn-primary"
      end
      br
      link "Don't have an account?", to: Signup::Index
    end
  end
end
