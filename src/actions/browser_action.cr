abstract class BrowserAction < Lucky::Action
  include CheckLogin
  include Lucky::ProtectFromForgery
  accepted_formats [:html, :json], default: :html
end
