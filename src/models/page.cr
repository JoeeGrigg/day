class Page < BaseModel
  table do
    column timestamp : Time
    column name : String
    column content : String

    has_many attachments : Attachment

    # TODO: Add belongs to user
  end

  JS_DATE_FORMAT = "%FT%T.%LZ"
  DISPLAY_DATE_FORMAT = "%A, %-d %B %Y @ %l:%M %P"
end