Sequel.migration do
  up do
    rename_table :possessions, :notes
  end
  down do
    rename_table :notes, :possessions
  end
end
