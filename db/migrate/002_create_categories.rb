Sequel.migration do
  up do
    create_table :categories do
      primary_key :id
      String :name
      Integer :level_lower
      Integer :level_upper
      foreign_key :row_id, :rows
    end

    categories = {
      'Tinkerers' => %w{Sundry Beastcoin},
      'Battlecraft' => [
        "Gladiator's Arm",
        "Pugilist's Arm",
        "Marauder's Arm",
        "Lancer's Arm",
        "Archer's Arm",
        "Shield",
        "Arrow",
        "Throwing Blade",
        "Throwing Stone",
        "Throwing Circle",
        "Throwing Axe",
        "Throwing Spear",
      ],
      'Spellcraft' => [
        "Conjurer's Arm",
        "Two-Handed Conjurer's Arm",
        "Thaumaturge's Arm",
        "Two-Handed Thaumaturge's Arm"
      ],
      'Fieldcraft' => [
        "Miner's Primary Tool",
        "Miner's Secondary Tool",
        "Botanist's Primary Tool",
        "Botanist's Secondary Tool",
        "Fisher's Primary Tool",
        "Fisher's Secondary Tool",
        "Bait",
        "Lure"
      ],
      'Tradescraft' => [
        "Carpenter's Primary Tool",
        "Carpenter's Secondary Tool",
        "Blacksmith's Primary Tool",
        "Blacksmith's Secondary Tool",
        "Armorer's Primary Tool",
        "Armorer's Secondary Tool",
        "Goldsmith's Primary Tool",
        "Goldsmith's Secondary Tool",
        "Leatherworker's Primary Tool",
        "Leatherworker's Secondary Tool",
        "Weaver's Primary Tool",
        "Weaver's Secondary Tool",
        "Alchemist's Primary Tool",
        "Alchemist's Secondary Tool",
        "Culinarian's Primary Tool",
        "Culinarian's Secondary Tool"
      ],
      'Armorfitters' => %w{Helm Full\ Plate War\ Garb Gauntlets Greaves},
      "Tailors" => [
        'Hat',
        'Headwear',
        'Mask',
        'Undershirt',
        'Attire',
        'Hooded Attire',
        'Undergarment',
        'Pants',
        'Gloves',
        'Armband',
        'Shoes',
        'Sandals',
        'Belt',
        'Sash'
      ],
      'Jewelers' => %w{Necklace Earring Bracelet Ring Crown Eyewear},
      'Grocers' => [
        'Meat Dish',
        'Egg Dish',
        'Grain Dish',
        'Vegetable Dish',
        'Mushroom Dish',
        'Sweet',
        'Drink',
        'Seafood Dish',
        'Soup & Stew',
        'Egg',
        'Dairy Product',
        'Vegetable',
        'Grain',
        'Spice',
        'Fruit',
        'Mushroom',
        'Seasoning',
        'Foodstuff',
        'Freshwater Fare',
        'Saltwater Fare',
        'Meat'
      ],
      'Chirurgeons' => %w{Potion Remedy Ether Toxin Panacea Reagent Dye Paint Oil},
      'Ironmongers' => [
        'Metal',
        'Unrefined Metal',
        'Metal Sheet',
        'Metal Wire',
        'Weapon Part',
        'Weapon Head',
        'Weapon Butt',
        'Weapon Grip',
        'Arrowhead',
        'Shaft',
        'Hook',
        'Chainmail Mesh',
        'Armor Metal',
        'Clasp'
      ],
      'Woodcutters' => %w{Raw\ Wood Lumber Plank},
      'Tanners' => [
        'Hide',
        'Leather',
        'Fur',
        'Armor Hide',
        'Armor Leather',
        'Footwear Part',
        'Bone',
        'Tooth & Claw',
        'Wing',
        'Scute & Scale'
      ],
      'Masons' => %w{Ore Stone Gemstone},
      'Clothiers' => [
        'Fiber',
        'Cloth',
        'Hooded Attire Cloth',
        'Cloth Body',
        'Smallclothes Cloth',
        'Cloth Sleeve',
        'Front Cloth',
        'Back Cloth',
        'Armor Cloth',
        'Feather',
        'Fletching',
        'Armor Part'
      ],
      'Crystaliers' => %w{Crystal}
    }

    self[:rows].each do |row|
      level_lower = nil
      level_upper = nil
      name = row[:name]

      if name =~ /(Lower|Middle|Upper) Tailors/
        name = "Tailors"
        case $1
        when "Lower"
          level_lower = 1
          level_upper = 20
        when "Middle"
          level_lower = 21
          level_upper = 40
        when "Upper"
          level_lower = 41
          level_upper = 50
        end
      end

      cats = categories[name]
      raise "#{row[:name]} has no categories" if cats.nil?

      self[:categories].import(
        [:name, :level_lower, :level_upper, :row_id],
        cats.collect { |c| [c, level_lower, level_upper, row[:id]] }
      )
    end
  end
end
