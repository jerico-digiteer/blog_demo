class Post < ApplicationRecord
    scope :published, -> { where("publish_date <= ?", Date.today) }
  end
  