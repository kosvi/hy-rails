class AddConfirmedToMembership < ActiveRecord::Migration[7.0]
  def up
    add_column :memberships, :confirmed, :boolean
    Membership.update_all confirmed: false
  end

  def down
    remove_column :memberships, :confirmed
  end
end
