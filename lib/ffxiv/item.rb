module FFXIV
  class Item < Sequel::Model
    many_to_one :category
  end
end
