class RemoveTeacherAttendances < ActiveRecord::Migration
  def up
    Lesson.all.each do |lesson|
      if lesson.users.include?(lesson.teacher)
        lesson.users.delete(lesson.teacher)
      end
    end
  end

  def down
    # noop
  end
end
