# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    user.present? ?
      send(user.type.downcase) : guest
  end

  def guest
    can :read, Book
    can :read, Author
    can :read, Category
    can :read, Publisher
  end

  def customer
    guest
  end

  def admin
    can :manage, Book
    can :manage, Author
    can :manage, Category
    can :manage, Publisher
    can :manage, User
  end
end
