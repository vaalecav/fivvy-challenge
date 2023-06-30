# frozen_string_literal: true

# == Schema Information
#
# Table name: disclaimers
#
#  id         :bigint           not null, primary key
#  name       :string
#  text       :text
#  version    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Disclaimer class
class Disclaimer < ApplicationRecord
  validates :name, presence: true
  validates :text, presence: true
  validates :version, presence: true

  has_many :acceptance
end
