module FFXIV
  class Category < Sequel::Model
    many_to_one :row
  end
end
