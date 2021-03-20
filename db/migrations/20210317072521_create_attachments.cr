class CreateAttachments::V20210317072521 < Avram::Migrator::Migration::V1
  def migrate
    create table_for(Attachment) do
      primary_key id : UUID
      add_timestamps

      add_belongs_to page : Page, on_delete: :cascade, foreign_key_type: UUID
      add key : String
    end
  end

  def rollback
    drop table_for(Attachment)
  end
end
