class Attachments::Show < BrowserAction
  get "/attachments/:page_id/:attachment_id" do
    attachment = AttachmentQuery.new
      .where_page(
        PageQuery.new
          .user_id(current_user.id)
          .id(page_id)
      )
      .find(attachment_id)
    redirect attachment.url
  end
end
