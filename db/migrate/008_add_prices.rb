Sequel.migration do
  up do
    create_table :prices do
      primary_key :id
      Integer :value
      foreign_key :item_id, :items
      foreign_key :user_id, :users
      DateTime :created_at
    end
  end
  down do
    drop_table :prices
  end
end
