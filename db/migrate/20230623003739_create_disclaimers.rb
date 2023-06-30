# frozen_string_literal: true

# Create Disclaimers table
class CreateDisclaimers < ActiveRecord::Migration[7.0]
  def change
    create_table :disclaimers do |t|
      t.string :name, null: false
      t.text :text, null: false
      t.string :version, null: false

      t.timestamps
    end
  end
end
