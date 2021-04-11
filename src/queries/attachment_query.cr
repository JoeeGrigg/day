class AttachmentQuery < Attachment::BaseQuery
  include Avram::SoftDelete::Query
end