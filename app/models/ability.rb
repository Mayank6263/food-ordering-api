# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    if user.admin?
      can :manage, :all
    else
      can :read, [Restaurant, MenuItem]
      can %i[create read], [Order, OrderItem]
      can [:update, :destroy], Order do |order|
        order.user == user
      end
      can [:update, :destroy], OrderItem do |orderitem|
        orderitem.user == user
      end
    end
  end
end
