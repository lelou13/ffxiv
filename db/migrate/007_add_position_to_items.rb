Sequel.migration do
  up do
    add_column :items, :position, Integer
  end
  down do
    drop_column :items, :position
  end
end
