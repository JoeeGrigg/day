class ConfirmRecoverEmail::IndexPage < IndexLayout
  needs confirmed : Bool = false

  def content
    if confirmed?
      para "New recovery email validated..."
      link "Back to profile", to: Profile::Index
    else
      para "Invalid token given..."
    end
  end
end
