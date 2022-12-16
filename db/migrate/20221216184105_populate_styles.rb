class PopulateStyles < ActiveRecord::Migration[7.0]
  def up
    Beer.select('style').group('style').each { | style | Style.create name: style.style }
  end

  def down
    Style.delete_all
  end
end
