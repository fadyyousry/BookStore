# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    user.present? ?
      send(user.type) : customer
  end

  def customer

  end

  def admin

  end
end