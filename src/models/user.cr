class User < BaseModel
  table do
    column identifier : UUID
    column encrypted_password : String
    column name : String?
    column recovery_email : String?
  end
end
