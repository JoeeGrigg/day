class Attachment < BaseModel
  table do
    belongs_to page : Page
  end
end
