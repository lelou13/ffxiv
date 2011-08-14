module FFXIV
  class Item < Sequel::Model
    many_to_one :category
    one_to_many :prices, :order => :created_at.desc

    def validate
      super
      validates_presence [:name, :category_id]
      validates_unique [:name, :category_id]
    end
  end
end
