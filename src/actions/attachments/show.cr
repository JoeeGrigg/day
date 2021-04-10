class Attachments::Show < BrowserAction
  get "/attachments/:page_id/:attachment_id" do
    attachment = AttachmentQuery.new.page_id(page_id).find(attachment_id)
    redirect attachment.url
  end
end
