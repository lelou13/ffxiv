module FFXIV
  class User < Sequel::Model
    set_restricted_columns(:provider, :uid)
    one_to_many :characters

    plugin :nested_attributes
    nested_attributes(:characters) { |hsh| hsh[:name].empty? }

    def validate
      super
      validates_presence [:name]
      validates_unique :name

      if new?
        # make sure character names are unique
        names = []
        characters.each_with_index do |character, i|
          if names.include?(character.name)
            errors.add(:"character_#{i+1}", "has a duplicated name")
          else
            names << character.name
          end
        end
      end
    end
  end
end
