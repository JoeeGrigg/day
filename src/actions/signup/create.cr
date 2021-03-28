class Signup::Create < BrowserAction
  post "/signup" do
    SaveUser.create(params) do |operation, user|
      if user
        flash.success = "Successfully signed up"
        redirect to: Signup::Show.with(user_id: user.id)
      else
        flash.failure = "Signup Failed"
        html Signup::IndexPage, op: operation
      end
    end
  end
end
