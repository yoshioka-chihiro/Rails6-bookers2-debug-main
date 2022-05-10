class TagRelationship < ApplicationRecord
  belongs_to :book
  belongs_to :tag
  
  validates :tag_id, presence: true
  validates :book_id, presence: true
end
