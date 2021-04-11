class Attachments::Update < ApiAction
  put "/attachments/:page_id/:attachment_id" do
    attachment = AttachmentQuery.new.for_action(
      current_user.id,
      attachment_id,
      page_id
    )
    attachment.restore
    json({restored: true})
  end
end