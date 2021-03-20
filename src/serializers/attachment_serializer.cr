class AttachmentSerializer < BaseSerializer
  def initialize(@attachment : Attachment)
  end

  def render
    {
      id: @attachment.id
    }
  end
end