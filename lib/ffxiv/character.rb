module FFXIV
  class Character < Sequel::Model
    many_to_one :user

    def validate
      super
      validates_presence [:name]
      validates_unique [:name, :user_id]
    end
  end
end
