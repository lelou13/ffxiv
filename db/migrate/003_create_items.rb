Sequel.migration do
  up do
    create_table :items do
      primary_key :id
      String :name
      Integer :optimal_rank
      foreign_key :category_id, :categories
    end
  end
  down do
    drop_table(:items)
  end
end
