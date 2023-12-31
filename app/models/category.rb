class Category < ApplicationRecord
  has_many :discussions, dependent: :nullify

  after_create_commit -> { broadcast_prepend_to 'categories' }
  after_update_commit -> { broadcast_replace_to 'categories' }
  after_destroy_commit -> { broadcast_remove_to 'categories' }

  scope :sorted, -> { order(name: :asc) }

  def to_param
    "#{id}-#{name.downcase.to_s[0..100]}".parameterize
  end
end
