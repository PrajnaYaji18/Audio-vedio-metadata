# frozen_string_literal: true

class CreateMedia < ActiveRecord::Migration[5.2]
  def change
    create_table :media do |t|
      t.string :asset_id
      t.string :title
      t.integer :duration
      t.string :file_location
      t.datetime :recorded_time
      t.references :account, foreign_key: true

      t.timestamps
    end
  end
end
