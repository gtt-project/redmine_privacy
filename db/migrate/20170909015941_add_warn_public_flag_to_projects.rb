class AddWarnPublicFlagToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :warn_when_creating_public_issue, :boolean, default: false
  end
end
