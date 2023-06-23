# frozen_string_literal: true

# Create Disclaimers table
class CreateDisclaimers < ActiveRecord::Migration[7.0]
  def change
    create_table :disclaimers do |t|
      t.string :name
      t.text :text
      t.integer :version

      t.timestamps
    end
  end
end
