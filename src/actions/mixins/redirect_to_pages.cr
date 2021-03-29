module RedirectToPages
  macro included
    before if_logged_in
  end

  private def if_logged_in
    redirect to: Pages::Index if current_user?
    continue
  end
end