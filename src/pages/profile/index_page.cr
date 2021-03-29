class Profile::IndexPage < MainLayout
  needs op : SaveProfile

  def content
    link "Back to Pages", to: Pages::Index
    h1 "Edit your profile"
    form_for Profile::Update do
      mount Shared::Field, attribute: op.name
      mount Shared::Field, attribute: op.recovery_email
      submit "Save"
    end
  end
end
