class ConfirmRecoveryEmail < BaseEmail
  def initialize(@email : String, @link : String); end

  to @email
  subject "Recovery Email Confirmation"
  templates text
end