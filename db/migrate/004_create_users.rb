Sequel.migration do
  up do
    create_table(:users) do
      primary_key :id
      String :name
      String :provider
      String :uid
    end
  end
end
