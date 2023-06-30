# frozen_string_literal: true

# == Schema Information
#
# Table name: acceptances
#
#  id            :bigint           not null, primary key
#  disclaimer_id :bigint           not null
#  user_id       :bigint           not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
# Acceptance class
class Acceptance < ApplicationRecord
  belongs_to :disclaimer
  belongs_to :user
end
