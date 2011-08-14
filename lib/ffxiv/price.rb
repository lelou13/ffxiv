module FFXIV
  class Price < Sequel::Model
    many_to_one :item
    many_to_one :user

    def before_create
      super
      self.created_at = Time.now
    end
  end
end
