class Page < BaseModel
  table do
    column timestamp : Time
    column name : String
    column content : String
  end
end