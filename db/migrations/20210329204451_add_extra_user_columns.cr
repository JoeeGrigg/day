class AddExtraUserColumns::V20210329204451 < Avram::Migrator::Migration::V1
  def migrate
    alter table_for(User) do
      add name : String?
      add recovery_email : String?
    end
  end

  def rollback
    alter table_for(User) do
      remove :name
      remove :recovery_email
    end
  end
end
