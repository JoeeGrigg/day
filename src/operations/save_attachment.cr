class SaveAttachment < Attachment::SaveOperation
  file_attribute :file

  before_save do
    file.value.try { |f| upload_file(f) }
  end

  private def upload_file(f)
    result = Shrine.upload(File.new(f.tempfile.path), "store", metadata: { "filename" => f.filename })
    key.value = result.id
  end
end