class AddExtraUserFieldsForRecoverEmailSetting::V20210402131856 < Avram::Migrator::Migration::V1
  def migrate
    alter table_for(User) do
      add old_recovery_email : String?
      add recovery_email_confirmation_token : String?
    end
  end

  def rollback
    alter table_for(User) do
      remove :old_recovery_email
      remove :recovery_email_confirmation_token
    end
  end
end
