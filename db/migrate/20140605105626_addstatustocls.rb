class Addstatustocls < ActiveRecord::Migration
  def up
    add_column :cls, :status , :string
  end

  def down
    remove_column :cls, :status
  end
end
