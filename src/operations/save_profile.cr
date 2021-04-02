class SaveProfile < User::SaveOperation
  permit_columns name, recovery_email

  before_save validate_recovery_email_format
  before_save prepare_new_recovery_email, if: :recovery_email_just_set?
  after_commit send_recovery_email_confirmation, if: :recovery_email_just_set?

  private def send_recovery_email_confirmation(user : User)
    return unless user.recovery_email
    ConfirmRecoveryEmail.new(
      email: user.recovery_email.as(String),
      link: ConfirmRecoverEmail::Index.with(token: user.recovery_email_confirmation_token).url
    ).deliver
  end

  private def recovery_email_just_set?
    recovery_email.changed? && !recovery_email.changed?(to: nil)
  end

  private def prepare_new_recovery_email
    return unless recovery_email_just_set?
    if record.as(User).recovery_email_transitioning?
      recovery_email.add_error "can't be changed whilst waiting for a new value to be confirmed"
    else
      old_recovery_email.value = recovery_email.original_value
      recovery_email_confirmation_token.value = Random::Secure.hex(32)
    end
  end

  private def validate_recovery_email_format
    return unless recovery_email.value
    unless Valid.email?(recovery_email.value.as(String))
      recovery_email.add_error "must be an email address"
    end
  end
end
