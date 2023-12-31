class Discussion < ApplicationRecord
  belongs_to :user, default: -> { Current.user }
  belongs_to :category, counter_cache: true, touch: true
  has_many :posts, dependent: :destroy

  # discussion.category_name
  delegate :name, prefix: :category, to: :category, allow_nil: true

  validates :name, presence: true

  accepts_nested_attributes_for :posts

  scope :pinned_first, -> { order(pinned: :desc, updated_at: :desc) }

  broadcasts_to :category , inserts_by: :prepend
  after_create_commit -> { broadcast_prepend_to 'discussions' }
  after_update_commit -> { broadcast_replace_to 'discussions' }
  after_destroy_commit -> { broadcast_remove_to 'discussions' }

  def to_param
    "#{id}-#{name.downcase.to_s[0...100]}".parameterize
  end
end
