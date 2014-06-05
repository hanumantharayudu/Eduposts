class CreateCls < ActiveRecord::Migration
  def change
    create_table :cls do |t|
      t.integer :school_admin_id
      t.string :class_name
      t.timestamps
    end
  end
end
