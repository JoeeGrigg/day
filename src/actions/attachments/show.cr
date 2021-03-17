class Attachments::Show < BrowserAction
  get "/attachments/:attachment_id" do
    plain_text "Render something in Attachments::Show"
  end
end
