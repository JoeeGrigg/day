class ConfirmRecoverEmail::Index < BrowserAction
  skip check_login

  param token : String?

  get "/confirm_recover_email" do
    return html IndexPage unless token
    user = UserQuery.new.recovery_email_confirmation_token(token.as(String)).first?
    if user
      SaveConfirmRecoveryEmail.update(user) do |operation, user|
        if operation.saved?
          return html IndexPage, confirmed: true
        end
      end
    end
    html IndexPage
  end
end
