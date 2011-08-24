module FFXIV
  class Note < Sequel::Model
    set_restricted_columns(:character_id)
    many_to_one :item
    many_to_one :character

    plugin :nested_attributes
    nested_attributes(:item, :strict => false)

    def validate
      super
      validates_presence :character_id
      validates_presence :item_id unless new? && item
      validates_unique [:item_id, :character_id]
    end
  end
end
