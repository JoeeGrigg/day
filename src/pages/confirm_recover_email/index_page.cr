class ConfirmRecoverEmail::IndexPage < IndexLayout
  needs confirmed : Bool = false

  def content
    div class: "layout-center" do
      if confirmed?
        para "New recovery email validated..."
        link "Back to profile", to: Profile::Index
      else
        para "Invalid token given..."
      end
    end
  end
end
