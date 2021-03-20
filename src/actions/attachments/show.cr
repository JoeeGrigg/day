class Attachments::Show < BrowserAction
  get "/attachments/:page_id/:attachment_id" do
    attachment = AttachmentQuery.new.page_id(page_id).find(attachment_id)
    html ShowPage, url: attachment.url
  end
end
