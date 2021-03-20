class Attachment < BaseModel
  table do
    column key : String
    
    belongs_to page : Page
  end

  def file
    Shrine::UploadedFile.new(key, "store")
  end

  def url
    file.url
  end
end
