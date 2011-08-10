Sequel.migration do
  up do
    create_table(:rows) do
      primary_key :id
      String :name
    end

    self[:rows].import([:name], [
      'Tinkerers',
      'Battlecraft',
      'Spellcraft',
      'Fieldcraft',
      'Tradescraft',
      'Armorfitters',
      'Lower Tailors',
      'Middle Tailors',
      'Upper Tailors',
      'Jewelers',
      'Grocers',
      'Chirurgeons',
      'Ironmongers',
      'Woodcutters',
      'Tanners',
      'Masons',
      'Clothiers',
      'Crystaliers'
    ])
  end
  down do
    drop_table(:rows)
  end
end
