class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.references :owner, index: true
      t.string :name

      t.timestamps
    end
  end
end
