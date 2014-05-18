class RemoveTextFromPages < ActiveRecord::Migration
  def change
    remove_column :pages, :text, :string
  end
end
