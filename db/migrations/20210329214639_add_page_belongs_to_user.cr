class AddPageBelongsToUser::V20210329214639 < Avram::Migrator::Migration::V1
  def migrate
    alter table_for(Page) do
      add_belongs_to user : User, on_delete: :cascade, foreign_key_type: UUID
    end
  end

  def rollback
    alter table_for(Page) do
      remove_belongs_to :user
    end
  end
end
