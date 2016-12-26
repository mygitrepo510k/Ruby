# @author: Hammad

class Ability
  include CanCan::Ability


  def initialize(user)
    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, published: true
    #
    # See the wiki for details:
    # https://github.com/ryanb/cancan/wiki/Defining-Abilities

    alias_action :create, :read, :update, :destroy, to: :crud
    alias_action :read, :update, :destroy, to: :rud

    user ||= User.new # guest user

    if user.role?(:sysadmin)
      can :manage, :all
    elsif user.role?(:manager)
      manager_permissions(user)
    elsif user.role?(:supervisor)
      supervisor_permissions(user)
    elsif user.role?(:support)
      support_permissions(user)
    elsif user.role?(:patient)
      patient_permissions(user)
    elsif user.role?(:doctor)
      doctor_permissions(user)
    elsif user.role?(:nurse)
      nurse_permissions(user)
    end
  end

  def can_access_admin
    can :read, ActiveAdmin::Page, name: "Dashboard"
  end

  def manager_permissions(user)
    can_access_admin
  end

  def supervisor_permissions(user)
    can_access_admin
  end

  def support_permissions(user)
    can_access_admin
  end

  def patient_permissions(user)
    can :manage, Order, user_id: user.id
    can :manage, Prescription, user_id: user.id
    general_permissions(user)
  end

  def doctor_permissions(user)
    if user.try(:linked_doctor)
      can :create, Prescription, doctor_id: nil, user_id: nil
      can :manage, Prescription, doctor_id: user.linked_doctor.id
      can :rud, DoctorPatient, doctor_id: user.linked_doctor.id
      can :read, User do |patient|
        user.patients.include?(patient)
      end
    end
    can :create, Doctor do |doctor|
      user.linked_doctor.nil?
    end
    can :rud, Doctor do |doctor|
      doctor.user_id.nil? or doctor.user_id == user.id
    end
    can :create, DoctorPatient
    general_permissions(user)
  end

  def nurse_permissions(user)
  end

  def general_permissions(user)
    can :manage, User, id: user.id
    can :manage, Profile, user_id: user.id
  end
end
