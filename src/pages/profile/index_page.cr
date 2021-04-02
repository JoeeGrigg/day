class Profile::IndexPage < MainLayout
  needs op : SaveProfile

  def content
    div class: "layout-center" do
      link "Back to Pages", to: Pages::Index
      h1 "Edit your profile"
      form_for Profile::Update do
        mount Shared::Field, attribute: op.name
        if op.record.as(User).recovery_email_transitioning?
          mount Shared::Field, attribute: op.recovery_email do |input_html|
            input_html.email_input(disabled: true)
            span "Cannot change recovery email again whilst waiting for confirmation"
            br
            link "Cancel recovery email change", to: ConfirmRecoverEmail::Delete.with(token: op.recovery_email_confirmation_token.value)
            if op.old_recovery_email.value
              br
              span "Current value being replaced: #{op.old_recovery_email.value}"
            end
          end
        else
          mount Shared::Field, attribute: op.recovery_email, &.email_input
        end
        submit "Save"
      end
    end
  end
end
