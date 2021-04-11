class Attachment < BaseModel
  include Avram::SoftDelete::Model

  table do
    column key : String
    column soft_deleted_at : Time?
    
    belongs_to page : Page
  end

  # TODO: Periodically delete soft deleted attachments

  def file
    Shrine::UploadedFile.new(key, "store")
  end

  def url
    file.url
  end
end
