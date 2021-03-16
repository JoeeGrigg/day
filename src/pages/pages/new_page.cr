class Pages::NewPage < MainLayout
  needs op : SavePage

  def content
    h1 "New Page"
    form_for Pages::Create do
      mount Shared::Field, attribute: op.name
      mount Shared::Field, attribute: op.timestamp, &.datetime_input
      mount Shared::Field, attribute: op.content, &.textarea
      submit "Save"
    end
  end
end
