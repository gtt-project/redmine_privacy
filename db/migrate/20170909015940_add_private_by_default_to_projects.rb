class AddPrivateByDefaultToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :issues_private_by_default, :boolean, default: false
  end
end
