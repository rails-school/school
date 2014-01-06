class DropTranslations < ActiveRecord::Migration
  def self.up
    drop_table :translations
  end

  def self.down
    create_table :translations do |t|
      t.string :locale
      t.string :key
      t.text   :value
      t.text   :interpolations
      t.boolean :is_proc, :default => false

      t.timestamps
    end
  end
end
