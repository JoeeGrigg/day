class Attachments::Create < ApiAction
  post "/attachments/:page_id" do
    page = PageQuery.new.find(page_id)
    SaveAttachment.create(file: params.nested_file("attachment")["file"], page_id: page.id) do |op, attachment|
    # raise params.nested_file?("attachment").inspect
    # SaveAttachment.create(params, page_id: page.id) do |op, attachment|
      if attachment
        plain_text "Uploaded"
      else
        plain_text "Failed to upload"
      end
    end
  end
end