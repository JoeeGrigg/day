class CreateLogins::V20210328090748 < Avram::Migrator::Migration::V1
  def migrate
    # Learn about migrations at: https://luckyframework.org/guides/database/migrations
    create table_for(Login) do
      primary_key id : UUID
      add_timestamps

      add_belongs_to user : User, on_delete: :cascade, foreign_key_type: UUID
      add token : String
    end
  end

  def rollback
    drop table_for(Login)
  end
end
