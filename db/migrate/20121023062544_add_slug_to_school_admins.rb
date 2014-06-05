class AddSlugToSchoolAdmins < ActiveRecord::Migration
  def change
    add_column :school_admins, :slug,:string
    add_index :school_admins, :slug
  end
end
