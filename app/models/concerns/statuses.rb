module Statuses
  VALID_STATUSES = ['public', 'private', 'archived']

  def valid_statuses
    @valid_statuses = VALID_STATUSES
  end
end