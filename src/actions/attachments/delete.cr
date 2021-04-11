class Attachments::Delete < ApiAction
  delete "/attachments/:page_id/:attachment_id" do
    attachment = AttachmentQuery.new.for_action(
      current_user.id,
      attachment_id,
      page_id
    )
    attachment.soft_delete
    json({deleted: true})
  end
end
