# frozen_string_literal: true

module NameValidateable
  extend ActiveSupport::Concern

  module ClassMethods
    def name_validateable(item)
      validate do
        items = item.capitalize.constantize.where(name: name)
        errors.add(:name, "has already been taken in #{item.capitalize}") if items.present?
      end
    end
  end
end
