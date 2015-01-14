class CreateGroupUsers < ActiveRecord::Migration
  def change
    create_table :group_users do |t|
      t.references :user, index: true
      t.references :group, index: true

      t.timestamps
    end
  end
end
