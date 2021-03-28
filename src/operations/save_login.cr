class SaveLogin < Login::SaveOperation
  getter user : User?

  attribute identifier : String
  attribute password : String

  before_save validate

  private def validate
    validate_required identifier
    validate_required password
    validate_user_found
    validate_password_correct
    generate_token unless token.value
  end

  private def validate_user_found
    return unless identifier.value
    @user = UserQuery.new.identifier(identifier.value.as(String)).first?
    if user
      user_id.value = user.as(User).id
    else
      identifier.add_error "not found"
    end
  end

  private def validate_password_correct
    return unless user && password.value
    user_password = Crypto::Bcrypt::Password.new(user.as(User).encrypted_password)
    unless user_password.verify(password.value.as(String))
      password.add_error "incorrect"
    end
  end

  private def generate_token
    return if token.value
    token.value = Random::Secure.hex(64)
  end
end
