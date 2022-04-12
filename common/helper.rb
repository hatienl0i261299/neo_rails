# frozen_string_literal: true

def pagination(data)
  {
    total_entries: data&.total_entries,
    previous_page: data&.previous_page,
    current_page: data&.current_page,
    next_page: data&.next_page,
    per_page: data&.per_page,
    offset: data&.offset,
    total_pages: data&.total_pages
  }
end

def str_to_int(string)
  string.to_i if string.to_i.to_s == string
rescue StandardError
  nil
end

def str_to_boolean(string)
  case string.to_s
  when 'true'
    true
  when 'false'
    false
  end
rescue StandardError
  nil
end

# Define text for GroupRole
class GroupRole
  attr_reader :admin, :user, :viewer

  def initialize
    @admin = 'admin'
    @user = 'user'
    @viewer = 'viewer'
  end
end

# Define text for ReasonError
class ReasonError
  attr_reader :validateError

  def initialize
    @validateError = 'Validation failed: '
  end
end

FORMAT_DATETIME_OUTPUT = '%H:%M:%S %d-%m-%Y'
