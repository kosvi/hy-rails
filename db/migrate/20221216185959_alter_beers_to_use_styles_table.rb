class AlterBeersToUseStylesTable < ActiveRecord::Migration[7.0]
  def up
    rename_column :beers, :style, :old_style
    add_reference :beers, :style, index: true
    Beer.all.each do |beer|
      style = Style.find_by name: beer.old_style
      beer.style_id = style.id
      beer.save
    end
  end

  def down
    Beer.all.each do |beer|
      style = beer.style
      beer.old_style = style.name
      beer.save
    end
    remove_reference :beers, :style, index: true
    rename_column :beers, :old_style, :style
  end
end
