class AddPostsCountToDiscussions < ActiveRecord::Migration[7.1]
  def change
    add_column :discussions, :post_count, :integer, default: 0
  end
end
