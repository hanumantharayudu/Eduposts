class AddAdminIdToSchoolAdmins < ActiveRecord::Migration
  def change
    add_column :school_admins, :admin_id, :integer
  end
end
