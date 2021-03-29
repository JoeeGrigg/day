class Pages::Create < BrowserAction
  post "/pages" do
    SavePage.create(
      name: "New Page",
      timestamp: Time.utc,
      content: "Please give some content",
      user_id: current_user.id
    ) do |operation, page|
      if page
        flash.success = "Page created"
        redirect to: Pages::Index.with(p: page.id)
      else
        raise "Failed to create page"
      end
    end
  end
end
