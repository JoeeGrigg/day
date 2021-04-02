class SaveConfirmRecoveryEmail < User::SaveOperation
  before_save confirm_recover_email

  private def confirm_recover_email
    old_recovery_email.value = nil
    recovery_email_confirmation_token.value = nil
  end
end
