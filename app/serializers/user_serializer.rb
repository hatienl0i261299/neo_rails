# frozen_string_literal: true

class UserSerializer < ApplicationSerializer
  attributes :id,
             :username,
             :first_name,
             :last_name,
             :email,
             :status,
             :ticket,
             :group,
             :created_at,
             :updated_at
  # has_one :ticket, serializer: TicketSerializer
  belongs_to :group, serializer: GroupSerializer
  # has_many :roles, serializer: RoleSerializer
  # has_one :status, serializer: StatusSerializer

  # def roles
  #     object.roles.order('roles.id ASC').map do |role|
  #         {
  #             id: role.id,
  #             name: role.name
  #         }
  #     end
  # end
  #
  # def group
  #     {
  #         group_name: object.group_name,
  #         group_role: object.group_role,
  #     }
  # end
end
