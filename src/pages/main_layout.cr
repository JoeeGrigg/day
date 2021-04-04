abstract class MainLayout
  include Lucky::HTMLPage

  abstract def content
  abstract def page_title

  # The default page title. It is passed to `Shared::LayoutHead`.
  #
  # Add a `page_title` method to pages to override it. You can also remove
  # This method so every page is required to have its own page title.
  def page_title
    "Pages"
  end

  needs user : User

  def render
    html_doctype

    html lang: "en" do
      mount Shared::LayoutHead, page_title: page_title, context: context

      body do
        mount Shared::FlashMessages, context.flash
        render_header
        render_content
      end
    end
  end

  def render_header
    header do
      link to: Pages::Index, class: "branding" do
        h1 "Day"
      end
      div class: "actions" do
        link "New Page", to: Pages::Create, class: "btn btn-primary btn-header"
        span class: "seperator"
        link to: Profile::Index, class: "profile" do
          span user.name.to_s, class: "name" if user.name
          div class: "icon" do
            img src: asset("images/user.svg")
          end
        end
        link "Logout", to: Login::Delete, class: "logout btn btn-header"
      end
    end
  end

  def render_content
    div class: "content" do
      content
    end
  end
end
