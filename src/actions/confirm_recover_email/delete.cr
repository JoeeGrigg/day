class ConfirmRecoverEmail::Delete < BrowserAction
  skip check_login

  param token : String?

  delete "/confirm_recover_email" do
    return html IndexPage unless token
    user = UserQuery.new.recovery_email_confirmation_token(token.as(String)).first?
    if user
      SaveCancelRecoveryEmail.update(user) do |operation, user|
        if operation.saved?
          redirect to: Profile::Index
        end
      end
    end
    html IndexPage
  end
end
