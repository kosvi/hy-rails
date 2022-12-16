class AlterBeersToUseStylesTable < ActiveRecord::Migration[7.0]
  def up
    rename_column :beers, :style, :old_style
    add_reference :beers, :style, index: true
  end

  def down
    rename_column :beers, :old_style, :style
    remove_reference :beers, :style, index: true
  end
end
