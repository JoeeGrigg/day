class User < BaseModel
  table do
    column identifier : UUID
    column encrypted_password : String

    # TODO: Add recovery email that is optional
    # TODO: Add name
  end
end
