class User < BaseModel
  table do
    column identifier : UUID
    column encrypted_password : String
  end
end
