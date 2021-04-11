class AttachmentQuery < Attachment::BaseQuery
  include Avram::SoftDelete::Query

  alias ForActionID = String | UUID
  def for_action(user_id : ForActionID, id : ForActionID, page_id : ForActionID) : Attachment
    page_query = PageQuery.new.user_id(user_id).id(page_id)

    where_page(page_query).find(id)
  end
end