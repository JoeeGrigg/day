class SaveCancelRecoveryEmail < User::SaveOperation
  before_save cancel_recover_email

  private def cancel_recover_email
    recovery_email.value = old_recovery_email.value
    old_recovery_email.value = nil
    recovery_email_confirmation_token.value = nil
  end
end
