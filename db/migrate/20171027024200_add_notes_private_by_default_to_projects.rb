class AddNotesPrivateByDefaultToProjects < ActiveRecord::Migration[5.2]
  def change
    add_column :projects, :issue_notes_private_by_default, :boolean, default: false
  end
end

