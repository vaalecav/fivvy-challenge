# rubocop:disable Layout/LineLength
# frozen_string_literal: true

task routes: :environment do
  puts `bundle exec rails routes | awk '!/active_storage/ && !/action_mailbox/ && !/turbo_/' | sed 's/                           / /'`
end

# rubocop:enable Layout/LineLength
