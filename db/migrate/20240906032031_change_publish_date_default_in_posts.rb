class ChangePublishDateDefaultInPosts < ActiveRecord::Migration[7.2]
  def change
    change_column_default :posts, :publish_date, nil
  end
  
end
