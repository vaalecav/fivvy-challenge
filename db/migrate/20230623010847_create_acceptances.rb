# frozen_string_literal: true

# Create Acceptances table
class CreateAcceptances < ActiveRecord::Migration[7.0]
  def change
    create_table :acceptances do |t|
      t.references :disclaimer, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
