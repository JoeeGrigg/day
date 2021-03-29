class SaveProfile < User::SaveOperation
  permit_columns name, recovery_email

  # TODO: Add confirm recovery email
end
