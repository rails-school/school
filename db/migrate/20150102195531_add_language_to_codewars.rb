class AddLanguageToCodewars < ActiveRecord::Migration
  def change
    add_column :codewars, :language, :string
  end
end
