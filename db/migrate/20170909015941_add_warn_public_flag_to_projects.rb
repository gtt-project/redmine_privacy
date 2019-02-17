class AddWarnPublicFlagToProjects < ActiveRecord::Migration[5.2]
  def change
    add_column :projects, :warn_when_creating_public_issue, :boolean, default: false
  end
end
