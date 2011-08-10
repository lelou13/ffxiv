Sequel.migration do
  up do
    create_table(:possessions) do
      primary_key :id
      foreign_key :item_id, :items
      foreign_key :character_id, :characters
      TrueClass :keep
      String :note
    end
  end
  down do
    drop_table(:possessions)
  end
end
