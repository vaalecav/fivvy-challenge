# frozen_string_literal: true

# Disclaimer class
class Disclaimer < ApplicationRecord
  validates :name, presence: true
  validates :text, presence: true
  validates :version, presence: true

  has_many :acceptance
end
