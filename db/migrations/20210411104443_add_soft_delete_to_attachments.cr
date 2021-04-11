class AddSoftDeleteToAttachments::V20210411104443 < Avram::Migrator::Migration::V1
  def migrate
    alter table_for(Attachment) do
      add soft_deleted_at : Time?
    end
  end

  def rollback
    alter table_for(Attachment) do
      remove :soft_deleted_at
    end
  end
end
