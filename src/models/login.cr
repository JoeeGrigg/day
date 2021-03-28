class Login < BaseModel
  table do
    belongs_to user : User
    column token : String
  end

  COOKIE_NAME = "login_token"

  # TODO: Add login expiry
end
