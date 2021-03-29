class SaveNewUsers::V20210326072420 < Avram::Migrator::Migration::V1
  def migrate
    # Learn about migrations at: https://luckyframework.org/guides/database/migrations
    create table_for(User) do
      primary_key id : UUID
      add_timestamps

      add identifier : UUID
      add encrypted_password : String
    end
  end

  def rollback
    drop table_for(User)
  end
end
