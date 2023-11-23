class RenamePostsCountColumnFromDiscussion < ActiveRecord::Migration[7.1]
  def change
    rename_column :discussions, :post_count, :posts_count
  end
end
