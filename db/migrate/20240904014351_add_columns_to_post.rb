class AddColumnsToPost < ActiveRecord::Migration[7.2]
  def change
    add_column :posts, :active, :boolean, default: true
    add_column :posts, :featured, :boolean, default: false
    add_column :posts, :publish_date, :date, default: Date.today
  end
end
