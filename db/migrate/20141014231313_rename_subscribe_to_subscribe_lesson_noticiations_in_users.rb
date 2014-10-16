class RenameSubscribeToSubscribeLessonNoticiationsInUsers < ActiveRecord::Migration
  def change
    rename_column :users, :subscribe, :subscribe_lesson_notifications
  end
end
