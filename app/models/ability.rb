class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    can    :read, :all

    can    :read,   User
    can    :manage, User, id: user.id

    cannot :read, School

    if user.admin?
      can :manage, :all
    elsif user.teacher?
      can :manage, [Lesson]
    end

    # admins and teachers who have @railsschool.org email addresses can send notifications
    if (user.admin? || user.teacher?) && (user.email.match(/railsschool.org\Z/))
      can :notify, Lesson do |lesson|
        user.school == lesson.venue.school
      end
    end

  end
end
