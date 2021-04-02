class Profile::Update < BrowserAction
  put "/profile" do
    SaveProfile.update(current_user, params) do |operation, user|
      if operation.saved?
        if operation.recovery_email.changed? && !operation.recovery_email.changed?(to: nil)
          flash.success = "Saved. Please check your email to confirm your new recovery email..."
        else
          flash.success = "Saved"
        end
        redirect to: Profile::Index
      end
      html Profile::IndexPage, op: operation, user: user
    end
  end
end
