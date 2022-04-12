# frozen_string_literal: true

class Test < ActiveRecord::Migration[6.1]
  def up
    Status.create name: 'Active', active: true
    Status.create name: 'Inactive', active: false
  end

  def down
    status = Status.all
    status.map(&:destroy!)
  end
end
