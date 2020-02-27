class AddTimecodeToMedia < ActiveRecord::Migration[5.2]
  def change
    add_column :media, :timecode, :string
  end
end
