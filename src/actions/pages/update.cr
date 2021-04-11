class Pages::Update < BrowserAction
  put "/pages/:page_id" do
    page = PageQuery.new.user_id(current_user.id).find(page_id)
    SavePage.update(page, params) do |operation, contact|
      if operation.saved?
        flash.success = "Page saved"
        redirect to: Pages::Index.with(p: page.id)
      else
        raise "Failed to save page"
      end
    end
  end
end
