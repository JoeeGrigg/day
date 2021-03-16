class CreatePages::V20210315162550 < Avram::Migrator::Migration::V1
  def migrate
    create table_for(Page) do
      primary_key id : UUID
      add_timestamps

      add timestamp : Time
      add name : String
      add content : String
    end
  end

  def rollback
    drop table_for(Page)
  end
end
