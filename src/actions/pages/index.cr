class Pages::Index < BrowserAction
  # TODO: Page errors if tried to be accessed when not logged in
  param p : UUID?

  get "/pages" do
    pages = PageQuery.new.timestamp.desc_order
    page = p ? PageQuery.new.find(p.not_nil!) : nil
    html IndexPage,
         pages: pages,
         page: page,
         user: current_user
  end
end