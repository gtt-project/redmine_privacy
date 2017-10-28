class AddNotesPrivateByDefaultToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :issue_notes_private_by_default, :boolean, default: false
  end
end

