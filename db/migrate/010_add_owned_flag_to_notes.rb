Sequel.migration do
  up do
    add_column :notes, :owned, TrueClass
  end
  down do
    remove_column :notes, :owned
  end
end
