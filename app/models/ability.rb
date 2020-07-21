# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    @user = user
    @user.present? ?
      send(@user.type.downcase) : guest
  end

  def guest
    can :read, Book
    cannot :read, Book, product_id: nil
    can :read, Author
    can :read, Category
    can :read, Publisher
  end

  def customer
    guest
    unless @user.customer_id.nil?
      can :manage, Sale, user_id: @user.id
      cannot :destroy, Sale, status: "Complete"
    end
  end

  def admin
    can :manage, Book
    can :manage, Author
    can :manage, Category
    can :manage, Publisher
    can :manage, User
    can :read, Sale

    cannot :destroy, User, id: @user.id
  end
end
