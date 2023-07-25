# frozen_string_literal: true

module Orderable
  extend ActiveSupport::Concern

  included do
    before_create :set_position

    def last_position
      throw NotImplementedError
    end

    def set_position
      self.position = last_position + 1
    end

    def move_lower
      return if position == last_position

      next_element = self.class.find_by(position: position + 1)
      return if next_element.blank?

      ActiveRecord::Base.transaction do
        next_element.update!(position:)
        update!(position: position + 1)
      end
    end

    def move_higher
      return if position.zero?

      previous_element = self.class.find_by(position: position - 1)
      return if previous_element.blank?

      ActiveRecord::Base.transaction do
        previous_element.update!(position:)
        update!(position: position - 1)
      end
    end
  end
end
