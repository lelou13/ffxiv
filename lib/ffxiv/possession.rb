module FFXIV
  class Possession < Sequel::Model
    set_restricted_columns(:character_id)
    many_to_one :item
    many_to_one :character

    plugin :nested_attributes
    nested_attributes(:item)
  end
end
