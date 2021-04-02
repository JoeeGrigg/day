class User < BaseModel
  table do
    column identifier : UUID
    column encrypted_password : String
    column name : String?
    column recovery_email : String?
    column old_recovery_email : String?
    column recovery_email_confirmation_token : String?
    # TODO: Expire recovery email confirmation token
  end

  def recovery_email_transitioning?
    old_recovery_email || recovery_email_confirmation_token
  end
end
