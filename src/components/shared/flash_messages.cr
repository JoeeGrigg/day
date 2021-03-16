class Shared::FlashMessages < BaseComponent
  needs flash : Lucky::FlashStore

  def render
    div class: "flash-messages hidden", data_controller: "flash" do
      ul do
        flash.each do |flash_type, flash_message|
          li class: "flash-message flash-type-#{flash_type}", flow_id: "flash" do
            text flash_message
          end
        end
      end
    end
  end
end
