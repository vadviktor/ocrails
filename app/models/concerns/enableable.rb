# frozen_string_literal: true

module Enableable
  extend ActiveSupport::Concern

  included do
    validates :enabled, inclusion: [true, false]

    scope :enabled, -> { where(enabled: true) }
    scope :disabled, -> { where(enabled: false) }
  end

  def toggle!
    enabled? ? disable! : enable!
  end

  def disabled?
    !enabled
  end

  def enable!
    update!(enabled: true)
  end

  def disable!
    update!(enabled: false)
  end
end
