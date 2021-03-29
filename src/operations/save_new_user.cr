class SaveNewUser < User::SaveOperation
  attribute password : String
  attribute password_confirmation : String
  permit_columns name, recovery_email

  before_save handle_input

  def handle_input
    validate_required password
    validate_required password_confirmation
    validate_confirmation_of password, with: password_confirmation
    encrypt_password(password.value) if password.value
    generate_identifier unless identifier.value
  end

  private def encrypt_password(value : String?)
    if value
      encrypted_password.value = Crypto::Bcrypt::Password.create(value, cost: 10).to_s
    end
  end

  private def generate_identifier
    return if identifier.value
    identifier.value = UUID.random
  end
end
