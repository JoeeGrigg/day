class Pages::IndexPage < MainLayout
  needs pages : PageQuery
  needs page : Page?

  def content
    div class: "index" do
      render_pages_list
      div class: "page" do
        div class: "page-container" do
          page ? render_page : render_no_page
        end
      end
    end
  end

  def render_pages_list
    div class: "pages" do
      ul do
        month = Time.utc.month
        year = Time.utc.year
        pages.each_with_index do |page, i|
          if page.timestamp.month != month
            li class: "month-seperator" do 
              text page.timestamp.to_s("%B#{page.timestamp.year != year ? " %Y" : ""}")
            end if i > 0
            month = page.timestamp.month
          end
          link to: Pages::Index.with(p: page.id) do
            li do
              span page.name, class: "name"
              span page.timestamp.to_s(Page::DISPLAY_DATE_FORMAT), class: "timestamp"
            end
          end
        end
      end
    end
  end

  def render_no_page
    para "Please select a page"
  end

  def render_page
    p = page.as(Page)
    form_for Pages::Update.with(page_id: p.id), data_controller: "page-form", data_page_form_target: "form" do
      div class: "header" do
        input name: "page:timestamp", class: "timestamp datetime", value: p.timestamp.to_s(Page::JS_DATE_FORMAT), data_action: "input->page-form#handleChange"
        input name: "page:name", class: "name", value: p.name, data_action: "input->page-form#handleChange"
      end
      input value: p.content, id: "page:content", name: "page:content", type: "hidden"
      tag "trix-editor", input: "page:content", id: "page-trix-editor", class: "page-content"
    end
  end
end