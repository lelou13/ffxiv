module FFXIV
  class Item < Sequel::Model
    many_to_one :category

    def validate
      super
      validates_presence [:name, :category_id]
      validates_unique [:name, :category_id]
    end
  end
end
