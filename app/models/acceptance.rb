# frozen_string_literal: true

# Acceptance class
class Acceptance < ApplicationRecord
  belongs_to :disclaimer
  belongs_to :user
end
