class Attachments::ShowPage
  include Lucky::HTMLPage

  needs url : String

  def render
    img src: url
  end
end
