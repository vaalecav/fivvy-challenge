# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Disclaimer, type: :model do
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:text) }
  it { is_expected.to validate_presence_of(:version) }
  it { is_expected.to have_many(:acceptance) }
end
