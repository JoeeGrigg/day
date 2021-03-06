class Attachments::Create < ApiAction
  post "/attachments/:page_id" do
    page = PageQuery.new.user_id(current_user.id).find(page_id)
    attachment = SaveAttachment.create!(file: params.nested_file("attachment")["file"], page_id: page.id)
    json(AttachmentSerializer.new(attachment), HTTP::Status::CREATED)
  end
end