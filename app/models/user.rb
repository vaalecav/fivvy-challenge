# frozen_string_literal: true

# User class
class User < ApplicationRecord
  has_many :acceptance
end
