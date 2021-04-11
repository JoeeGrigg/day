class Attachments::Show < BrowserAction
  get "/attachments/:page_id/:attachment_id" do
    attachment = AttachmentQuery.new.for_action(
      current_user.id,
      attachment_id,
      page_id
    )
    redirect attachment.url
  end
end
