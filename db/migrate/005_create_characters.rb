Sequel.migration do
  up do
    create_table(:characters) do
      primary_key :id
      String :name
      foreign_key :user_id, :users
    end
  end
  down do
    drop_table(:characters)
  end
end
